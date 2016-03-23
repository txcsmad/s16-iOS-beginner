//
//  ViewController.swift
//  Magic Conch
//
//  Created by Jesse Tipton on 3/22/16.
//  Copyright © 2016 MAD. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    let synthesizer = AVSpeechSynthesizer()
    var circle: CircleView?
    var start: CGPoint {
        return CGPointApplyAffineTransform(imageView.center, CGAffineTransformMakeTranslation(100, -50))
    }
    
    func didTapConch() {
        let utterance = AVSpeechUtterance(string: MagicConchResponse.randomResponse().rawValue)
        synthesizer.speakUtterance(utterance)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        synthesizer.delegate = self
        
        circle = CircleView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        circle?.center = start
        imageView.addSubview(circle!)
    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        circle?.center = touches.first!.locationInView(imageView)
        imageView.setNeedsDisplay()
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        UIView.animateWithDuration(2) {
            self.circle?.center = self.start
            self.didTapConch()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: AVSpeechSynthesizerDelegate {
    
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        print(characterRange)
    }
    
}
