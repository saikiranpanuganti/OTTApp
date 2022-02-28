//
//  PlayerViewController.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 03/10/21.
//

import UIKit

class PlayerViewController: UIViewController {
    @IBOutlet weak var playerView: PlayerView!
    var viewModel: PlayerViewModel = PlayerViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerView.delegate = self
        viewModel.delegate = self
        viewModel.getVideoUrl()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if let progress = playerView.videoPlayerView?.getCurrentTime(), let duration = playerView.videoPlayerView?.getDuration() {
            viewModel.saveProgress(progress: Int(progress), duration: Int(duration))
        }
    }
}

extension PlayerViewController: PlayerViewModelDelegate {
    func updateUI() {
        DispatchQueue.main.async {
            self.playerView.videoUrl = self.viewModel.videoUrl
            self.playerView.updateUI()
        }
    }
}

extension PlayerViewController: PlayerViewDelegate {
    func closeTapped() {
        dismiss(animated: true, completion: nil)
    }
}
