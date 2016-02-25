//
//  BuildingsViewController.swift
//  Buildings
//
//  Created by Jesse Tipton on 2/9/16.
//  Copyright © 2016 MAD. All rights reserved.
//

import UIKit
import RealmSwift

class BuildingsViewController: UITableViewController {
    
    let realm = try! Realm()

    var buildings: Results<Building> {
        let realm = try! Realm()
        return realm.objects(Building)
    }
    
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
        
        cell.imageView?.image = building.image ?? nil
        
        return cell
    }
    
    @IBAction func didTapAdd(sender: AnyObject) {
        let alertController = UIAlertController(title: "New Building", message: nil, preferredStyle: .Alert)
        
        alertController.addTextFieldWithConfigurationHandler { textField in
            textField.placeholder = "Building name"
        }
        
        alertController.addTextFieldWithConfigurationHandler { textField in
            textField.keyboardType = .NumberPad
            textField.placeholder = "Building height"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let createAction = UIAlertAction(title: "Create", style: .Default) { (action: UIAlertAction) in
            let nameTextField = alertController.textFields!.first!
            let heightTextField = alertController.textFields!.last!
            
            let realm = try! Realm()
            
            try! realm.write {
                let building = Building()
                building.name = nameTextField.text ?? ""
                building.height = Int(heightTextField.text!) ?? 0
                realm.add(building)
                 
                dispatch_async(dispatch_get_main_queue()) {
                    self.tableView.insertRowsAtIndexPaths([NSIndexPath(forItem: self.buildings.count - 1, inSection: 0)], withRowAnimation: .Automatic)
                }
            }
        }
        alertController.addAction(createAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DetailsSegue" {
            if let row = tableView.indexPathForSelectedRow?.row,
                detailsViewController = segue.destinationViewController as? BuildingDetailViewController {
                    detailsViewController.building = buildings[row]
            }
        }
    }
    
    // MARK: - Deleting rows
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .Delete
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let realm = try! Realm()
        try! realm.write {
            let building = buildings[indexPath.row]
            realm.delete(building)
            
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
        }
    }
    
}
