//
//  ViewController.swift
//  TouchTesting
//
//  Created by 박종찬 on 2017. 7. 1..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var centerView: UIView!
    @IBOutlet weak var aroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print(touches.count)
        print("touchesBegan")
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        print("\(centerView .center)로부터 \(touches.first!.location(in: aroundView))까지 거리는", distance(from: centerView.center, to: touches.first!.location(in: aroundView)))
        
    }
    
    func distance(from: CGPoint, to: CGPoint) -> Double {
        let width: Double = Double(from.x - to.x)
        let height: Double = Double(from.y - to.y)
        let pitagoras: Double = (width * width) + (height * height)
        
        return pitagoras.squareRoot()
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print(touches.count)
        
        
        print("touchesEnded")
    }


}

