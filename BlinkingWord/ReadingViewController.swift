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
    var readingSpeed: Double = 0.5
    let initialSpeed: Double = 0.5
    let minimumSpeed: Double = 0.1
    var isReading: Bool = false
    @IBOutlet weak var centerView: UIView!
    @IBOutlet weak var aroundView: UIView!
    
    @IBOutlet weak var readingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.isUserInteractionEnabled = true
    }
    
    override func viewDidLayoutSubviews() {
        self.aroundView.layer.cornerRadius = aroundView.bounds.size.width / 2
        self.centerView.layer.cornerRadius = centerView.bounds.size.width / 2
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        pauseReading()
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
        self.timer = Timer.scheduledTimer(withTimeInterval: self.readingSpeed, repeats: true) { [unowned self] (timer: Timer) in
            self.readingLabel.text = self.sourceText.wordArray[self.readingIndex]
            self.readingIndex += 1
            if self.sourceText.wordArray.count == self.readingIndex {
                timer.invalidate()
                self.isReading = false
                self.readingIndex = 0
            }
        }
    }
    
    func pauseReading() {
        self.timer?.invalidate()
        self.isReading = false
    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.readingSpeed = initialSpeed
        self.startReading()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touchDistance = distance(from: centerView.center, to: touches.first!.location(in: aroundView))
        
        if touchDistance > 160.0 {
            self.pauseReading()
            
        } else {
            
            let newSpeed = initialSpeed - distance(from: centerView.center, to: touches.first!.location(in: aroundView)) / 360.0
            let difference = self.readingSpeed - newSpeed
            
            
            
            if abs(difference) > 0.07 {
                
                self.pauseReading()
                
                print("newSpeed", newSpeed)
                
                if newSpeed > minimumSpeed && newSpeed < initialSpeed {
                    self.readingSpeed = newSpeed
                } else if newSpeed > initialSpeed {
                    self.readingSpeed = initialSpeed
                } else if newSpeed < minimumSpeed {
                    self.readingSpeed = minimumSpeed
                }
                
                self.startReading()
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.pauseReading()
    }
    
    func distance(from: CGPoint, to: CGPoint) -> Double {
        let width: Double = Double(from.x - to.x)
        let height: Double = Double(from.y - to.y)
        let pitagoras: Double = (width * width) + (height * height)
        
        return pitagoras.squareRoot()
    }
    
}
