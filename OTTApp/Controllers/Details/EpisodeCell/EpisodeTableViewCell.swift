//
//  EpisodeTableViewCell.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 17/09/21.
//

import UIKit

protocol EpisodeTableViewCellDelegate: AnyObject {
    
}

class EpisodeTableViewCell: UITableViewCell {
    @IBOutlet weak var episodeImage: UIImageView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    weak var delegate: EpisodeTableViewCellDelegate?
    var episode: Episode?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func configureUI(episode: Episode?) {
        if let episode = episode {
            self.episode = episode
            if let url = URL(string: episode.imagery?.mobileImg ?? "") {
                episodeImage.sd_setImage(with: url, completed: nil)
            }
            titleLabel.text = String(episode.episodeNumber ?? 1) + ". " + (episode.title ?? "")
            let durationInt = (episode.length ?? 0)/60
            duration.text = String(durationInt) + "m"
            descriptionLabel.text = episode.synopsis
        }
    }
    
    @IBAction func episodeTapped(_ sender: UIButton) {
        print("episode number is: ", episode?.episodeNumber)
    }
}
