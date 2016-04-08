//
//  MasterViewController.swift
//  Podcasts
//
//  Created by Jesse Tipton on 4/4/16.
//  Copyright © 2016 Jesse Tipton. All rights reserved.
//

import UIKit

class SubscriptionsViewController: UITableViewController {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let identifier = segue.identifier else { return }
        switch identifier {
        case "Feed":
            let feedViewController = segue.destinationViewController as! FeedViewController
        default: break
        }
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        return cell
    }
    
}
