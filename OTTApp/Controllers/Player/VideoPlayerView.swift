//
//  VideoPlayerView.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 03/10/21.
//

import UIKit
import AVKit

protocol VideoPlayerViewDelegate: AnyObject {
    func updateProgress(progress: Float)
}

class VideoPlayerView: UIView {
    weak var delegate: VideoPlayerViewDelegate?
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
            
            player?.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: DispatchQueue.main) { (CMTime) -> Void in
                if self.player?.currentItem?.status == .readyToPlay {
                    let currentTime = self.getCurrentTime()
                    self.delegate?.updateProgress(progress: currentTime)
                }
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        videoLayer?.frame = self.bounds
    }
    
    func seekToTime(toTime: Float) {
        var timeScale: Int32 = 1000
        if let timeScaleValue = player?.currentItem?.asset.duration.timescale {
            timeScale = timeScaleValue
        }
        
        let newTime: CMTime = CMTimeMakeWithSeconds(Float64(toTime), preferredTimescale: timeScale)
        
        player?.seek(to: newTime, completionHandler: { seekDone in
            if seekDone {
                self.playVideo()
            }
        })
    }
    
    func getCurrentTime() -> Float {
        return Float(player?.currentItem?.currentTime().seconds ?? 0)
    }
    
    func getDuration() -> Float {
        return Float(player?.currentItem?.duration.seconds ?? 0)
    }
    
    func playVideo() {
        player?.play()
    }
    
    func pauseVideo() {
        player?.pause()
    }
}
