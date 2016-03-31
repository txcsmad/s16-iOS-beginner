//
//  ViewController.swift
//  Decibels
//
//  Created by Jesse Tipton on 3/30/16.
//  Copyright © 2016 MAD. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var meterView: DecibelMeterView! {
        didSet {
            meterView.delegate = self
        }
    }
    
    var recorder: AVAudioRecorder?
    
    var timer: NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let recorderSettings: [String: AnyObject] = [
            AVFormatIDKey: NSNumber(unsignedInt: kAudioFormatAppleIMA4),
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 1,
            AVLinearPCMBitDepthKey: 16,
            AVLinearPCMIsBigEndianKey: false,
            AVLinearPCMIsFloatKey: false
        ]
        
        let URL = NSURL(string: NSTemporaryDirectory().stringByAppendingFormat("/%@", "tmp.caf"))!
        
        recorder = try! AVAudioRecorder(URL: URL, settings: recorderSettings)
        recorder?.meteringEnabled = true
        recorder?.record()
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0 / 30.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }

    func update() {
        meterView.setNeedsDisplay()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: DecibelMeterViewDataSource {
    
    func currentValueForDecibelMeterView(meterView: DecibelMeterView) -> Float {
        recorder?.updateMeters()
        let decibels = recorder?.averagePowerForChannel(0)
        return decibels!
    }
    
}
