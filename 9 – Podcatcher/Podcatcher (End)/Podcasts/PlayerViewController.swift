//
//  DetailViewController.swift
//  Podcasts
//
//  Created by Jesse Tipton on 4/4/16.
//  Copyright © 2016 Jesse Tipton. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var playPauseButton: UIButton!

    @IBAction func playPause() {
        if playing {
            player?.pause()
            playPauseButton.setTitle("Play", forState: .Normal)
        } else {
            player?.play()
            playPauseButton.setTitle("Pause", forState: .Normal)
        }
        playing = !playing
    }
    
    var episode: Episode?
    
    var player: AVPlayer?
    var playing: Bool = false
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let artworkURL = episode?.artworkURL {
            let imageData = NSData(contentsOfURL: artworkURL)!
            imageView.image = UIImage(data: imageData)
        }
        
        let playerItem = AVPlayerItem(URL: episode!.fileURL)
        player = AVPlayer(playerItem: playerItem)
    }
    
}
