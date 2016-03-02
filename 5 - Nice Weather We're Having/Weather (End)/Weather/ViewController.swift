//
//  ViewController.swift
//  Weather
//
//  Created by Jesse Tipton on 2/29/16.
//  Copyright © 2016 MAD. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dayTimeLabel: UILabel!
    
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    @IBOutlet var forecastDayLabels: [UILabel]!
    @IBOutlet var forecastTemperatureLabels: [UILabel]!
    @IBOutlet var forecastDescriptionLabels: [UILabel]!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var timer: NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: Configure location manager
        locationManager.delegate = self
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else {
            locationManager.startUpdatingLocation()
        }
        
        // TODO: Setup timer
        timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "updateForecast", userInfo: nil, repeats: true)
        timer?.fire()
    }
    
    func updateForecast() {
        // TODO: Get weather from the internets
        guard let location = currentLocation else { return }
        guard let URL = NSURL(string: "https://api.forecast.io/forecast/\(FORECAST_IO_API_KEY)/\(location.coordinate.latitude),\(location.coordinate.longitude)") else { return }
        let request = NSURLRequest(URL: URL)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            let JSON = try! NSJSONSerialization.JSONObjectWithData(data!, options: []) as! [String: AnyObject] // This is dangerous and bad (again) (again)
            let currently = JSON["currently"] as! [String: AnyObject] // Not safe
            let temperature = currently["temperature"] as! Double
            let feelsLike = currently["apparentTemperature"] as! Double
            let summary = currently["summary"] as! String
            
            // PSA: ONLY UPDATE THE UI ON THE MAIN THREAD
            dispatch_async(dispatch_get_main_queue()) {
                self.currentTemperatureLabel.text = "\(temperature)°, feels like \(feelsLike)°."
                self.descriptionLabel.text = "It's \(summary) out."
            }
        }
        task.resume()
    }
    
    // MARK: - CLLocationManagerDelegate

    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .AuthorizedAlways, .AuthorizedWhenInUse:
            manager.startUpdatingLocation()
        case .Denied, .Restricted:
            presentViewController(UIAlertController.locationAccessDisabledAlertController(), animated: true, completion: nil)
        case .NotDetermined:
            manager.requestWhenInUseAuthorization()
        }
    }
    
}










