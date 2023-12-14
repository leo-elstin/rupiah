## 0.5.0

* Dart's sound null safety is now supported.

## 0.4.0

* The PDFBoxResourceLoader is now used on Android to load PDF documents much faster than before. The fast initialization (i.e. *fastInit*) option has therefore been removed.
* PDF documents are no longer kept alive in the platform-specific scope. Instead, they are opened and closed at each read with the respective library functions. This does not affect the caching mechanism utilized directly in Dart. This change prevents errors due to multiple document accesses at the same time.
* Tests have been implemented.

## 0.3.1

* The possibility to initialize a document faster (without immediately initializing the text stripper engine) on Android has been added.

## 0.3.0

* A class for the PDF document information has been added. Now this information
is retrieved on the initialization of the document.

## 0.2.2

* Code formatting has been improved and minor issues solved.

## 0.2.1

* The support for password-encrypted PDF documents has been added.

## 0.2.0

* Some new methods have been added to PDFDoc:
    * fromURL to load a PDF document from an URL.
    * deleteFile to delete the file related to the document.
    * deleteAllExternalFiles to delete all the files of the document imported 
    from outside the local file system.

## 0.1.3

* Part of the internal logic has been simplified.

## 0.1.2

* A demo of the example app has been added.


## 0.1.1

* An issue that caused a crash on iOS, when retrieving the text of the last page of the entire document, has been fixed.


## 0.1.0

* The plugin is ready to be used.


## 0.0.1

* The first release is out! It provides support for iOS and Android.
