//
//  VideoPlayerView.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 03/10/21.
//

import UIKit
import AVKit

class VideoPlayerView: UIView {
    var player: AVPlayer?
    var videoLayer: AVPlayerLayer?
    var url: URL?
    
    func updateUIWithData(videoUrl: URL?) {
        if let videoUrl = videoUrl {
            url = videoUrl
            videoLayer?.removeFromSuperlayer()
            
            let playerItem = AVPlayerItem(url: videoUrl)
            player = AVPlayer(playerItem: playerItem)
            
            videoLayer = AVPlayerLayer(player: player)
            
            videoLayer?.frame = self.bounds
            videoLayer?.videoGravity = .resizeAspect
            
            if let videolayer = videoLayer {
                layer.addSublayer(videolayer)
            }
        }
    }
    
    func playVideo() {
        player?.play()
    }
    
    func pauseVideo() {
        player?.pause()
    }
}
