//
//  Building.swift
//  Buildings
//
//  Created by Jesse Tipton on 2/9/16.
//  Copyright © 2016 MAD. All rights reserved.
//

import UIKit
import RealmSwift

class Building: Object {
    
    dynamic var name: String = ""
    
    dynamic var height: Int = 0
    
    var image: UIImage? {
        return UIImage(named: name)
    }
    
}
