//
//  BuildingDetailViewController.swift
//  Buildings
//
//  Created by Jesse Tipton on 2/9/16.
//  Copyright © 2016 MAD. All rights reserved.
//

import UIKit

class BuildingDetailViewController: UIViewController {

    @IBOutlet weak var buildingImageView: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    
    var building: Building?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let building = building {
            buildingImageView.image = building.image
            detailLabel.text = "Bulding height: \(building.height) feet"
            navigationItem.title = building.name
        }
    }
}
