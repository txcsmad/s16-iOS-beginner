//
//  FeedViewController.swift
//  Podcasts
//
//  Created by Jesse Tipton on 4/4/16.
//  Copyright © 2016 Jesse Tipton. All rights reserved.
//

import UIKit

class FeedViewController: UITableViewController {
    
    var feedParser: FeedParser? {
        didSet {
            episodes = feedParser!.parse()
        }
    }
    var episodes = [Episode]()
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let identifier = segue.identifier else { return }
        switch identifier {
        case "Player":
            let playerViewController = segue.destinationViewController as! PlayerViewController
            let episode = episodes[tableView.indexPathForSelectedRow!.row]
            playerViewController.episode = episode
        default: break
        }
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let episode = episodes[indexPath.row]
        
        cell.textLabel?.text = episode.title
        
        return cell
    }
    
}
