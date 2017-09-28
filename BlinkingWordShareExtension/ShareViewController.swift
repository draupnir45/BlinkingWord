//
//  ShareViewController.swift
//  BlinkingWordShareExtension
//
//  Created by 박종찬 on 2017. 7. 18..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

import UIKit
import Social
import MobileCoreServices

class ShareViewController: SLComposeServiceViewController {

    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }

    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }

    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }
    
    override func viewDidLoad() {
        let extensionItem: NSExtensionItem = extensionContext?.inputItems.first as! NSExtensionItem
        let itemProvider: NSItemProvider = extensionItem.attachments?.first as! NSItemProvider
        let typePropertyList: String = String(kUTTypePropertyList)
        if itemProvider.hasItemConformingToTypeIdentifier(typePropertyList) {
            itemProvider.loadItem(forTypeIdentifier: typePropertyList, options: nil, completionHandler: { (item: NSSecureCoding?, error: Error!) in
                guard let dictionary = item as? NSDictionary else { return }
                OperationQueue.main.addOperation {
                    if let results = dictionary[NSExtensionJavaScriptPreprocessingResultsKey] as? NSDictionary,
                    let urlString = results["URL"] as? String {
                        print("\n\n\n\n", urlString, "\n\n\n\n")
                        let userDefaultForGroup: UserDefaults = UserDefaults.init(suiteName: "group.BlinkingWord")!
                        userDefaultForGroup.set(urlString, forKey: "urlString")
                    }
                }
            })
        } else {
            print("error")
        }
    }

}
