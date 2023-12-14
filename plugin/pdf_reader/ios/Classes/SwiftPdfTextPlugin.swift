import Flutter
import UIKit
import PDFKit


public class SwiftPdfTextPlugin: NSObject, FlutterPlugin {
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "pdf_text", binaryMessenger: registrar.messenger())
    let instance = SwiftPdfTextPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {

    DispatchQueue.global(qos: .default).async {
        if call.method == "initDoc" {
          let args = call.arguments as! NSDictionary
                let path = args["path"] as! String
                let password = args["password"] as! String
            self.initDoc(result: result, path: path, password: password)
        } else if call.method == "getDocPageText" {
              let args = call.arguments as! NSDictionary
              let path = args["path"] as! String
              let password = args["password"] as! String
              let pageNumber = args["number"] as! Int
            self.getDocPageText(result: result, path: path, password: password, pageNumber: pageNumber)
        }
           else if call.method == "getDocText" {
              let args = call.arguments as! NSDictionary
              let path = args["path"] as! String
              let password = args["password"] as! String
              let missingPagesNumbers = args["missingPagesNumbers"] as! [Int]
            self.getDocText(result: result, path: path, password: password, missingPagesNumbers: missingPagesNumbers)
        }
          else {
            DispatchQueue.main.sync {
                result(FlutterMethodNotImplemented)

            }
        }
    }
  }
    

  /**
              Initializes the PDF document and returns some information into the channel.
       */
      private func initDoc(result: FlutterResult, path: String, password: String) {
        let doc = getDoc(result: result, path: path, password: password)
        if doc == nil {
            return
        }
        // Getting the length of the PDF document in pages.
          let length = doc!.pageCount
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        
        let creationDate = doc!.documentAttributes![PDFDocumentAttribute.creationDateAttribute] != nil
            ? dateFormatter.string(from: (doc!.documentAttributes![PDFDocumentAttribute.creationDateAttribute]) as! Date)
        : nil
        
        let modificationDate = doc!.documentAttributes![PDFDocumentAttribute.modificationDateAttribute] != nil
        ? dateFormatter.string(from: (doc!.documentAttributes![PDFDocumentAttribute.modificationDateAttribute] as! Date))
        : nil

                
        let data = ["length": length, "info": ["author": doc!.documentAttributes![PDFDocumentAttribute.authorAttribute], "creationDate": creationDate,
        "modificationDate": modificationDate , "creator": doc!.documentAttributes![PDFDocumentAttribute.creatorAttribute],
        "producer": doc!.documentAttributes![PDFDocumentAttribute.producerAttribute], "keywords": doc!.documentAttributes![PDFDocumentAttribute.keywordsAttribute],
        "title": doc!.documentAttributes![PDFDocumentAttribute.titleAttribute], "subject": doc!.documentAttributes![PDFDocumentAttribute.subjectAttribute]]] as [String : Any]
    
        DispatchQueue.main.sync {
            result(data)
        }
      }
    
  
    /**
            Gets the text  of a document page, given its number.
     */
    private func getDocPageText(result: FlutterResult, path: String,
                                password: String, pageNumber: Int) {
      let doc = getDoc(result: result, path: path, password: password)
        if doc == nil {
            return
        }
        let text = doc!.page(at: pageNumber-1)!.string
        DispatchQueue.main.sync {
            result(text)
        }
    }
    
    /**
            Gets the text of the entire document.
            In order to improve the performance, it only retrieves the pages that are currently missing.
     */
    private func getDocText(result: FlutterResult, path: String,
                            password: String, missingPagesNumbers: [Int]) {
      let doc = getDoc(result: result, path: path, password: password)
        if doc == nil {
            return
        }
        var missingPagesTexts = [String]()
        missingPagesNumbers.forEach { (pageNumber) in
            missingPagesTexts.append(doc!.page(at: pageNumber-1)!.string!)
        }
        DispatchQueue.main.sync {
            result(missingPagesTexts)
        }
    }
    
    /**
           Gets a PDF document, given its path.
    */
    private func getDoc(result: FlutterResult, path: String, password: String = "") -> PDFDocument? {
        let doc = PDFDocument(url: URL(fileURLWithPath: path))
        if doc == nil {
            DispatchQueue.main.sync {
                result(FlutterError(code: "INVALID_PATH",
                message: "File path is invalid",
                details: nil))
            }
            return nil
        }
        if !doc!.unlock(withPassword: password) {
          DispatchQueue.main.sync {
                result(FlutterError(code: "INVALID_PASSWORD",
                message: "The password is invalid",
                details: nil))
            }
            return nil
        }
        return doc
    }
    

}
