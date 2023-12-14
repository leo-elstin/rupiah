import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_text/client_provider.dart';

const MethodChannel _CHANNEL = const MethodChannel('pdf_text');
const String _TEMP_DIR_NAME = ".flutter_pdf_text";

/// Class representing a PDF document.
/// In order to create a new [PDFDoc] instance, one of these static methods has
///  to be used: [PDFDoc.fromFile], [PDFDoc.fromPath], [PDFDoc.fromURL].
class PDFDoc {
  late File _file;
  late PDFDocInfo _info;
  late List<PDFPage> _pages;
  late String _password;

  PDFDoc._internal();

  /// Creates a [PDFDoc] object with a [File] instance.
  /// Optionally, takes a [password] for encrypted PDF documents.
  static Future<PDFDoc> fromFile(File file, {String password = ""}) async {
    var doc = PDFDoc._internal();
    doc._password = password;
    doc._file = file;
    late Map data;
    try {
      data = await _CHANNEL
          .invokeMethod('initDoc', {"path": file.path, "password": password});
    } on Exception catch (e) {
      return Future.error(e);
    }
    doc._pages = List.generate(data["length"], (i) => PDFPage._fromDoc(doc, i));
    doc._info = PDFDocInfo._fromMap(data["info"]);
    return doc;
  }

  /// Creates a [PDFDoc] object with a file path.
  /// Optionally, takes a [password] for encrypted PDF documents.
  static Future<PDFDoc> fromPath(String path, {String password = ""}) async {
    return await fromFile(File(path), password: password);
  }

  /// Creates a [PDFDoc] object with a URL.
  /// Optionally, takes a [password] for encrypted PDF documents.
  /// It downloads the PDF file located in the given URL and saves it
  /// in the app's temporary directory.
  static Future<PDFDoc> fromURL(String url, {String password = ""}) async {
    File file;
    try {
      String tempDirPath = (await getTemporaryDirectory()).path;

      String filePath = join(tempDirPath, _TEMP_DIR_NAME,
          url.split("/").last.split(".").first + ".pdf");

      file = File(filePath);
      file.createSync(recursive: true);
      file.writeAsBytesSync(
          (await ClientProvider().client.get(Uri.parse(url))).bodyBytes);
    } on Exception catch (e) {
      return Future.error(e);
    }
    return await fromFile(file, password: password);
  }

  /// Gets the page of the document at the given page number.
  PDFPage pageAt(int pageNumber) => _pages[pageNumber - 1];

  /// Gets the pages of this document.
  /// The pages indexes start at 0, but the first page has number 1.
  /// Therefore, if you need to access the 5th page, you will do:
  /// var page = doc.pages[4]
  /// print(page.number) -> 5
  List<PDFPage> get pages => _pages;

  /// Gets the number of pages of this document.
  int get length => _pages.length;

  /// Gets the information of this document.
  PDFDocInfo get info => _info;

  /// Gets the entire text content of the document.
  Future<String> get text async {
    // Collecting missing pages

    List<int> missingPagesNumbers = [];
    _pages.forEach((page) {
      if (page._text == null) {
        missingPagesNumbers.add(page.number);
      }
    });

    late List<String> missingPagesTexts;
    // Reading missing pages, if any exists
    if (missingPagesNumbers.isNotEmpty) {
      try {
        missingPagesTexts =
            List<String>.from(await (_CHANNEL.invokeMethod('getDocText', {
          "path": _file.path,
          "missingPagesNumbers": missingPagesNumbers,
          "password": _password
        })));
      } on Exception catch (e) {
        return Future.error(e);
      }
    }
    // Populating missing pages

    for (var i = 0; i < missingPagesNumbers.length; i++) {
      pageAt(missingPagesNumbers[i])._text = missingPagesTexts[i];
    }

    /// Returning the entire text, concatenating all pages
    return _pages.fold<String>("", (pv, page) => "$pv${page._text}");
  }

  /// Deletes the file related to this [PDFDoc].
  /// Throws an exception if the [FileSystemEntity] cannot be deleted.
  void deleteFile() {
    if (_file.existsSync()) {
      _file.deleteSync();
    }
  }

  /// Deletes all the files of the documents that have been imported
  /// from outside the local file system (e.g. using [fromURL]).
  static Future deleteAllExternalFiles() async {
    try {
      String tempDirPath = (await getTemporaryDirectory()).path;
      Directory dir = Directory(join(tempDirPath, _TEMP_DIR_NAME));

      if (dir.existsSync()) {
        dir.deleteSync(recursive: true);
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}

/// Class representing a PDF document page.
/// It needs not to be directly instantiated, instances will be automatically
/// created by the [PDFDoc] class.
class PDFPage {
  late PDFDoc _parentDoc;
  late int _number;
  String? _text;

  PDFPage._fromDoc(PDFDoc parentDoc, int number) {
    _parentDoc = parentDoc;
    _number = number;
  }

  /// Gets the text of this page.
  /// The text retrieval is lazy. So the text of a page is only loaded when
  /// it is requested for the first time.
  Future<String> get text async {
    // Loading the text
    if (_text == null) {
      try {
        _text = await _CHANNEL.invokeMethod('getDocPageText', {
          "path": _parentDoc._file.path,
          "number": number,
          "password": _parentDoc._password
        });
      } on Exception catch (e) {
        return Future.error(e);
      }
    }
    return _text!;
  }

  /// Gets the page number.
  int get number => _number + 1;
}

/// Class representing the information of a PDF document.
/// It needs not to be directly instantiated, instances will be automatically
/// created by the [PDFDoc] class.
class PDFDocInfo {
  String? _author;
  DateTime? _creationDate;
  DateTime? _modificationDate;
  String? _creator;
  String? _producer;
  List<String>? _keywords;
  String? _title;
  String? _subject;

  PDFDocInfo._fromMap(Map data)
      : this._internal(
            data["author"],
            data["creationDate"] != null
                ? DateTime.tryParse(data["creationDate"])
                : null,
            data["modificationDate"] != null
                ? DateTime.tryParse(data["modificationDate"])
                : null,
            data["creator"],
            data["producer"],
            data["keywords"] != null
                ? List<String>.from(data["keywords"])
                : null,
            data["title"],
            data["subject"]);

  PDFDocInfo._internal(
      this._author,
      this._creationDate,
      this._modificationDate,
      this._creator,
      this._producer,
      this._keywords,
      this._title,
      this._subject);

  /// Gets the author of the document. This contains the original string of the
  /// authors contained in the document. Therefore there might be multiple
  /// authors separated by comma. Returns null if no author exists.
  String? get author => _author;

  /// Gets the list of authors of the document. This is inferred by splitting
  /// the author string by comma. Returns null if no author exists.
  List<String>? get authors {
    if (author == null) {
      return null;
    }
    var authorString = author!.replaceAll(";", ",");
    authorString = authorString.replaceAll("&", ",");
    authorString = authorString.replaceAll("and", ",");
    List<String> splitted = authorString.split(",");
    List<String> ret = [];

    for (var token in splitted) {
      var start = 0;
      var end = token.length - 1;
      while (start < token.length && token[start] == ' ') {
        start++;
      }
      while (end >= 0 && token[end] == ' ') {
        end--;
      }
      if (end - start >= 0) {
        ret.add(token.substring(start, end + 1));
      }
    }
    return ret;
  }

  /// Gets the creation date of the document. Returns null if no creation
  /// date exists.
  DateTime? get creationDate => _creationDate;

  /// Gets the modification date of the document. Returns null if no
  /// modification date exists.
  DateTime? get modificationDate => _modificationDate;

  /// Gets the creator of the document. Returns null if no creator exists.
  String? get creator => _creator;

  /// Gets the producer of the document. Returns null if no producer exists.
  String? get producer => _producer;

  /// Gets the list of keywords of the document. Returns null if no keyword exists.
  List<String>? get keywords => _keywords;

  /// Gets the title of the document. Returns null if no title exists.
  String? get title => _title;

  /// Gets the subject of the document. Returns null if no subject exists.
  String? get subject => _subject;
}
