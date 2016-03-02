//
//  ViewController.swift
//  Weather
//
//  Created by Jesse Tipton on 2/29/16.
//  Copyright © 2016 MAD. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dayTimeLabel: UILabel!
    
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!


    
    @IBOutlet var forecastDayLabels: [UILabel]!
    @IBOutlet var forecastTemperatureLabels: [UILabel]!
    @IBOutlet var forecastDescriptionLabels: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: Configure location manager

        // TODO: Setup timer

    }
    
    func updateForecast() {
        // TODO: Get weather from the internets
    }
    
    // MARK: - CLLocationManagerDelegate

    // TODO: This
    
}
