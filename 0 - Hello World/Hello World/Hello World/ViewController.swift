//
//  ViewController.swift
//  Hello World
//
//  Created by Jesse Tipton on 1/25/16.
//  Copyright © 2016 MAD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    @IBAction func doAThing(sender: UIButton) {
        label.text = "Jesse is handsome"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
