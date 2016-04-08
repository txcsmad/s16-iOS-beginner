//
//  Magic.swift
//  Podcasts
//
//  Created by Jesse Tipton on 4/4/16.
//  Copyright © 2016 Jesse Tipton. All rights reserved.
//

import Foundation

let _ATP = Subscription(feedURL: NSURL(string: "http://atp.fm/episodes?format=rss")!)
let _BONANZA = Subscription(feedURL: NSURL(string: "https://relay.fm/bonanza/feed")!)
let _HI = Subscription(feedURL: NSURL(string: "http://www.hellointernet.fm/podcast?format=rss")!)
let _YLNT = Subscription(feedURL: NSURL(string: "http://feeds.feedburner.com/YouLookNiceToday")!)

let EXAMPLE_PODCASTS = [_ATP, _BONANZA, _HI, _YLNT]
