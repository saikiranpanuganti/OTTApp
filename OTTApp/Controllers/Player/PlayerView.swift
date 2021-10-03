//
//  PlayerView.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 03/10/21.
//

import UIKit

protocol PlayerViewDelegate: AnyObject {
    func closeTapped()
}

class PlayerView: UIView {
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var controlsView: UIView!
    @IBOutlet weak var playPauseImage: UIImageView!
    
    weak var delegate: PlayerViewDelegate?
    var videoPlayerView: VideoPlayerView?
    var videoUrl: String?
    
    func updateUI() {
        if videoPlayerView == nil {
            createVideoPlayerView()
            addTapGesture()
        }
        
        if videoPlayerView?.url == nil {
            guard let url = URL(string: videoUrl ?? "") else { return }
            videoPlayerView?.updateUIWithData(videoUrl: url)
            videoPlayerView?.playVideo()
        }
    }
    
    func createVideoPlayerView() {
        videoPlayerView = VideoPlayerView()
        videoPlayerView?.frame = playerView.bounds
        videoPlayerView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        if let videoPlayerView = videoPlayerView {
            playerView.addSubview(videoPlayerView)
        }
        videoPlayerView?.backgroundColor = Colors.shared.blackViewColor
    }
    
    func addTapGesture() {
        controlsView.isHidden = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideUnhideControlsView))
        tapGesture.numberOfTapsRequired = 1
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideUnhideControlsView() {
        controlsView.isHidden = !controlsView.isHidden
    }
    
    @IBAction func closeTapped() {
        delegate?.closeTapped()
    }
    
    @IBAction func forward() {
        print("forward")
    }
    
    @IBAction func backward() {
        print("backward")
    }
    
    @IBAction func playPause() {
        if playPauseImage.image == UIImage(systemName: "pause.circle.fill") {
            playPauseImage.image = UIImage(systemName: "play.circle.fill")
            videoPlayerView?.pauseVideo()
        }else {
            playPauseImage.image = UIImage(systemName: "pause.circle.fill")
            videoPlayerView?.playVideo()
        }
    }
}
