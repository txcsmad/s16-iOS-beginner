//
//  UIViewController.swift
//  Weather
//
//  Created by Jesse Tipton on 2/29/16.
//  Copyright © 2016 MAD. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentOKAlertController(title title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(okAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
}
