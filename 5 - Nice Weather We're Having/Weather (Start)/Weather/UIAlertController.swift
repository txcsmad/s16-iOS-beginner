//
//  Extensions.swift
//  Weather
//
//  Created by Jesse Tipton on 2/29/16.
//  Copyright © 2016 MAD. All rights reserved.
//

import UIKit

extension UIAlertController {

    static func locationAccessDisabledAlertController() -> UIAlertController {
        let alertController = UIAlertController(title: "Location Access Disabled", message: "In order to receive weather updates, please open this app's settings and set location access to 'While Using the App'.", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let openAction = UIAlertAction(title: "Open Settings", style: .Default) { action in
            if let url = NSURL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.sharedApplication().openURL(url)
            }
        }
        alertController.addAction(openAction)
        
        return alertController
    }
    
}
