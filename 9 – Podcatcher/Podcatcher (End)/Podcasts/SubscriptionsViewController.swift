//
//  MasterViewController.swift
//  Podcasts
//
//  Created by Jesse Tipton on 4/4/16.
//  Copyright © 2016 Jesse Tipton. All rights reserved.
//

import UIKit

class SubscriptionsViewController: UITableViewController {
    
    var subscriptions = EXAMPLE_PODCASTS
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let identifier = segue.identifier else { return }
        switch identifier {
        case "Feed":
            let feedViewController = segue.destinationViewController as! FeedViewController
            let subscription = subscriptions[tableView.indexPathForSelectedRow!.row]
            feedViewController.feedParser = FeedParser(feedURL: subscription.feedURL)
        default: break
        }
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subscriptions.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let subscription = subscriptions[indexPath.row]
        
        cell.textLabel?.text = subscription.feedURL.absoluteString
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let subscription = subscriptions[indexPath.row]
        let feedParser = FeedParser(feedURL: subscription.feedURL)
        feedParser.parse()
    }
    
}
