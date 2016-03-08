//
//  Building.swift
//  Buildings
//
//  Created by Jesse Tipton on 2/9/16.
//  Copyright © 2016 MAD. All rights reserved.
//

import UIKit

struct Building {
    
    let name: String
    
    let height: Int
    
    var image: UIImage? {
        return UIImage(named: name)
    }
    
}
