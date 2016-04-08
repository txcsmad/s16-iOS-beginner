//
//  PodcastFeedParser.swift
//  Podcasts
//
//  Created by Jesse Tipton on 4/4/16.
//  Copyright © 2016 Jesse Tipton. All rights reserved.
//

import Foundation

typealias EpisodeBuffer = (title: String?, artworkURL: NSURL?, fileURL: NSURL?)

class FeedParser: NSObject {
    
    private let parser: NSXMLParser
    
    private var buffer: EpisodeBuffer?
    
    private var currentElement: String?
    
    private var episodes: [Episode]?
    
    init(feedURL: NSURL) {
        self.parser = NSXMLParser(contentsOfURL: feedURL)!
        super.init()
        self.parser.delegate = self
    }
    
    func parse() -> [Episode] {
        episodes = []
        parser.parse()
        return episodes!
    }
    
    private func clearBuffer() {
        buffer = (nil, nil, nil)
    }
    
    private func addEpisodeFromBuffer() {
        guard let title = buffer?.title,
            fileURL = buffer?.fileURL else { fatalError("Buffer didn't have necessary elements") }
        let episode = Episode(title: title, artworkURL: buffer?.artworkURL, fileURL: fileURL)
        episodes?.append(episode)
    }
    
}

extension FeedParser: NSXMLParserDelegate {
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        currentElement = elementName
        
        switch elementName {
        case "item":
            clearBuffer()
        case "itunes:image":
            buffer?.artworkURL = NSURL(string: attributeDict["href"]!)
        case "enclosure":
            buffer?.fileURL = NSURL(string: attributeDict["url"]!)
        default: break
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if currentElement == "title" {
            buffer?.title = string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            addEpisodeFromBuffer()
            clearBuffer()
        }
    }
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        fatalError("Parser error occured: \(parseError)")
    }
    
}
