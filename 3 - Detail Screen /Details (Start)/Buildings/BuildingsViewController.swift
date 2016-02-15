//
//  BuildingsViewController.swift
//  Buildings
//
//  Created by Jesse Tipton on 2/9/16.
//  Copyright © 2016 MAD. All rights reserved.
//

import UIKit

class BuildingsViewController: UITableViewController {
    
    var buildings = [Building]()
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buildings.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BuildingCell", forIndexPath: indexPath)
        let building = buildings[indexPath.row]
        
        cell.textLabel?.text = building.name
        let unit = building.height == 1 ? "foot" : "feet"
        cell.detailTextLabel?.text = "\(building.height) \(unit)"
        
        if let image = building.image {
            cell.imageView?.image = image
        } else {
            cell.imageView?.image = nil
        }
        
        return cell
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildings.append(Building(name: "The Empire State Building", height: 1250))
        buildings.append(Building(name: "Rockefeller Center", height: 850))
        buildings.append(Building(name: "The Chrysler Building", height: 1050))
        buildings.append(Building(name: "The Flatiron Building", height: 285))
    }

}
