//
//  BlinkController.swift
//  BlinkingWord
//
//  Created by 박종찬 on 2017. 6. 25..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

import Foundation

struct SourceText {
    let originalString: String
    var wordArray: [String]
    
    init(withString string: String) {
        self.originalString = string
        let paragraphArray = originalString.components(separatedBy: "\n")
        self.wordArray = []
        for paragraph in paragraphArray {
            self.wordArray += paragraph.components(separatedBy: " ")
            self.wordArray.append(" ")
        }
    }
}
