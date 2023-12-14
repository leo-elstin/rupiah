package dev.aluc.pdf_text


import android.os.Handler
import android.os.Looper
import androidx.annotation.NonNull
import com.tom_roush.pdfbox.pdmodel.PDDocument
import com.tom_roush.pdfbox.text.PDFTextStripper
import com.tom_roush.pdfbox.util.PDFBoxResourceLoader
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import java.io.File
import kotlin.concurrent.thread

/** PdfTextPlugin */
class PdfTextPlugin: FlutterPlugin, MethodCallHandler {

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    val channel = MethodChannel(flutterPluginBinding.binaryMessenger, "pdf_text")
    channel.setMethodCallHandler(PdfTextPlugin())
    PDFBoxResourceLoader.init(flutterPluginBinding.applicationContext)
  }

  // This static function is optional and equivalent to onAttachedToEngine. It supports the old
  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
  // plugin registration via this function while apps migrate to use the new Android APIs
  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
  // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
  // depending on the user's project. onAttachedToEngine or registerWith must both be defined
  // in the same class.
  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "pdf_text")
      channel.setMethodCallHandler(PdfTextPlugin())
      PDFBoxResourceLoader.init(registrar.context())
    }
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    thread (start = true) {
      when (call.method) {
          "initDoc" -> {
            val args = call.arguments as Map<*, *>
            val path = args["path"] as String
            val password = args["password"] as String
            initDoc(result, path, password)
          }
          "getDocPageText" -> {
            val args = call.arguments as Map<*, *>
            val path = args["path"] as String
            val pageNumber = args["number"] as Int
            val password = args["password"] as String
            getDocPageText(result, path, pageNumber, password)
          }
          "getDocText" -> {
            val args = call.arguments as Map<*, *>
            val path = args["path"] as String
            @Suppress("UNCHECKED_CAST")
            val missingPagesNumbers = args["missingPagesNumbers"] as List<Int>
            val password = args["password"] as String
            getDocText(result, path, missingPagesNumbers, password)
          }
          else -> {
            Handler(Looper.getMainLooper()).post {
              result.notImplemented()
            }
          }
      }
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
  }

  /**
    Initializes the PDF document and returns some information into the channel.
   */
  private fun initDoc(result: Result, path: String, password: String) {
    getDoc(result, path, password)?.use { doc ->
      // Getting the length of the PDF document in pages.
      val length = doc.numberOfPages

      val info = doc.documentInformation

      var creationDate: String? = null
      if (info.creationDate != null) {
        creationDate = info.creationDate.time.toString()
      }
      var modificationDate: String? = null
      if (info.modificationDate != null) {
        modificationDate = info.modificationDate.time.toString()
      }
      val data = hashMapOf<String, Any>(
              "length" to length,
              "info" to hashMapOf("author" to info.author,
                      "creationDate" to creationDate,
                      "modificationDate" to modificationDate,
                      "creator" to info.creator, "producer" to info.producer,
                      "keywords" to splitKeywords(info.keywords),
                      "title" to info.title, "subject" to info.subject
              )
      )
      doc.close()
      Handler(Looper.getMainLooper()).post {
        result.success(data)
      }
    }
  }

  /**
   * Splits a string of keywords into a list of strings.
   */
  private fun splitKeywords(keywordsString: String?): List<String>? {
    if (keywordsString == null) {
      return null
    }
    val keywords = keywordsString.split(",").toMutableList()
    for (i in keywords.indices) {
      var keyword = keywords[i]
      keyword = keyword.dropWhile { it == ' ' }
      keyword = keyword.dropLastWhile { it == ' ' }
      keywords[i] = keyword
    }
    return keywords
  }

  /**
    Gets the text  of a document page, given its number.
   */
  private fun getDocPageText(result: Result, path: String, pageNumber: Int, password: String) {
    getDoc(result, path, password)?.use { doc ->
      val stripper = PDFTextStripper();
      stripper.startPage = pageNumber
      stripper.endPage = pageNumber
      val text = stripper.getText(doc)
      doc.close()
      Handler(Looper.getMainLooper()).post {
        result.success(text)
      }
    }
  }

  /**
  Gets the text of the entire document.
  In order to improve the performance, it only retrieves the pages that are currently missing.
   */
  private fun getDocText(result: Result, path: String, missingPagesNumbers: List<Int>, password: String) {
    getDoc(result, path, password)?.use { doc ->
      val missingPagesTexts = arrayListOf<String>()
      val stripper = PDFTextStripper();
      missingPagesNumbers.forEach {
        stripper.startPage = it
        stripper.endPage = it
        missingPagesTexts.add(stripper.getText(doc))
      }
      doc.close()
      Handler(Looper.getMainLooper()).post {
        result.success(missingPagesTexts)
      }
    }
  }

  /**
  Gets a PDF document, given its path.
   */
  private fun getDoc(result: Result, path: String, password: String = ""): PDDocument? {
    return try {
      PDDocument.load(File(path), password)
    } catch (e: Exception) {
      Handler(Looper.getMainLooper()).post {
        result.error("INVALID_PATH",
                "File path or password (in case of encrypted document) is invalid",
                null)
      }
      null
    }
  }
}
