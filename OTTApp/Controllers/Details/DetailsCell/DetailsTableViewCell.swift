//
//  DetailsTableViewCell.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 15/09/21.
//

import UIKit
import SDWebImage

protocol DetailsTableViewCellDelegate: AnyObject {
    func closeTapped()
}

class DetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var contentType: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var ageRating: UILabel!
    @IBOutlet weak var seasons: UILabel!
    @IBOutlet weak var playOrResume: UILabel!
    @IBOutlet weak var downloadLabel: UILabel!
    @IBOutlet weak var watchingView: UIView!
    @IBOutlet weak var watchingLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var remainingTime: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cast: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var title: UILabel!
    
    weak var delegate: DetailsTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpUI()
    }
    
    func setUpUI() {
        closeButton.layer.cornerRadius = 20.0
        watchingView.isHidden = true
    }
    
    func configureUI(details: Details?) {
        if let details = details {
            if let url = URL(string: details.imagery?.mobileImg ?? "") {
                contentImageView.sd_setImage(with: url, placeholderImage: nil, options: .highPriority, context: nil)
            }
            
            contentType.text = details.contentType ?? ""
            year.text = (details.productionYear?.count == 0) ? "2020" : details.productionYear
            ageRating.text = details.ageRating
            if let numberOfSeasons = details.seasons?.count {
                seasons.text = "\(numberOfSeasons) Seasons"
            }
            playOrResume.text = "Play"
            
            if details.contentType == "series" {
                downloadLabel.text = "Download S1:E1"
            }else {
                downloadLabel.text = "Download"
            }
            descriptionLabel.text = details.seoDescription
            cast.text = details.cast?.first
            genre.text = details.genres?.first
            title.text = details.title
        }
    }

    @IBAction func closeButton(_ sender: UIButton) {
        delegate?.closeTapped()
    }
}
