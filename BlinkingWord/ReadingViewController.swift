//
//  ReadingViewController.swift
//  BlinkingWord
//
//  Created by 박종찬 on 2017. 6. 25..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

import UIKit

class ReadingViewController: UIViewController {
    
    var timer: Timer?
    var sourceText: SourceText!
    var readingIndex: Int = 0
    var readingSpeed: Double = 0.4
    var isReading: Bool = false
    
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var readingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.isUserInteractionEnabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        pauseReading()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.startReading()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.pauseReading()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func start(_ sender: UIButton) {
        if !sender.isSelected {
            sender.isSelected = true
            self.startReading()
        } else {
            sender.isSelected = false
            self.pauseReading()
        }
        self.timer?.fire()
    }
    
    func startReading() {
        self.isReading = true
        self.timer = Timer.scheduledTimer(withTimeInterval: self.readingSpeed, repeats: true) { [unowned self](timer: Timer) in
            self.readingLabel.text = self.sourceText.wordArray[self.readingIndex]
            self.readingIndex += 1
            if self.sourceText.wordArray.count == self.readingIndex {
                timer.invalidate()
                self.isReading = false
                self.readingIndex = 0
                self.startButton.isSelected = false
            }
        }
    }
    
    func pauseReading() {
        self.timer?.invalidate()
        self.isReading = false
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        self.speedLabel.text = String.init(format: "%.2f", sender.value)
        self.readingSpeed = Double(sender.value)
        if self.isReading {
            pauseReading()
            startReading()
        }
    }
    
    
}
