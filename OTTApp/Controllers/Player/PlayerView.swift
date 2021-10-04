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
    @IBOutlet weak var closeButtonViewOutlet: UIView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var currentTime: UILabel!
    @IBOutlet weak var videoDuration: UILabel!
    
    weak var delegate: PlayerViewDelegate?
    var videoPlayerView: VideoPlayerView?
    var videoUrl: String?
    var updatedProgress: Bool = false
    
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
        videoPlayerView?.delegate = self
        videoPlayerView?.frame = playerView.bounds
        videoPlayerView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        if let videoPlayerView = videoPlayerView {
            playerView.addSubview(videoPlayerView)
        }
        videoPlayerView?.backgroundColor = Colors.shared.blackViewColor
    }
    
    func addTapGesture() {
        controlsView.isHidden = true
        closeButtonViewOutlet.isHidden = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideUnhideControlsView))
        tapGesture.numberOfTapsRequired = 1
        self.addGestureRecognizer(tapGesture)
    }
    
    func convertToString(time: Float) -> String {
        let timeInInt = Int(time)
        
        
        let seconds = timeInInt%60
        var secondsString = "\(seconds)"
        if seconds < 10 {
            secondsString = "0" + secondsString
        }
        
        let minutes = timeInInt/60
        var minutesString = "\(minutes)"
        if minutes < 10 {
            minutesString = "0" + minutesString
        }
        
        
        let hours = timeInInt/3600
        var hoursString = "\(hours)"
        if hours < 10 {
            hoursString = "0" + hoursString
        }
        
        return hoursString + ":" + minutesString + ":" + secondsString
    }
    
    @objc func hideUnhideControlsView() {
        controlsView.isHidden = !controlsView.isHidden
        closeButtonViewOutlet.isHidden = !closeButtonViewOutlet.isHidden
    }
    
    @IBAction func closeTapped() {
        delegate?.closeTapped()
    }
    
    @IBAction func forward() {
        let time: Float = videoPlayerView?.getCurrentTime() ?? 0
        videoPlayerView?.seekToTime(toTime: time + 10)
    }
    
    @IBAction func backward() {
        let time: Float = videoPlayerView?.getCurrentTime() ?? 0
        videoPlayerView?.seekToTime(toTime: time - 10)
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
    
    @IBAction func sliderValueChanged() {
        let seekToTime = slider.value*(videoPlayerView?.getDuration() ?? 0)
        currentTime.text = convertToString(time: seekToTime)
        videoPlayerView?.seekToTime(toTime: seekToTime)
    }
}

extension PlayerView: VideoPlayerViewDelegate {
    func updateProgress(progress: Float) {
        let duration = videoPlayerView?.getDuration()
        currentTime.text = convertToString(time: progress)
        slider.value = (progress/(duration ?? 0))
        
        if updatedProgress {
            updatedProgress = true
            videoDuration.text = convertToString(time: videoPlayerView?.getDuration() ?? 0)
        }
        
        videoDuration.text = convertToString(time: videoPlayerView?.getDuration() ?? 0)
    }
}
