//
//  SourceViewController.swift
//  BlinkingWord
//
//  Created by 박종찬 on 2017. 6. 25..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

import UIKit

class SourceViewController: UIViewController {

    var sourceText: SourceText?
    
    @IBOutlet weak var targetTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ReadingSegue" {
            let readingViewController: ReadingViewController = segue.destination as! ReadingViewController
            readingViewController.sourceText = SourceText.init(withString: targetTextView.text)
        }
    }
}
