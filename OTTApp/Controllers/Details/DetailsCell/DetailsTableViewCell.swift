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
    func playOrResumeTapped()
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
    @IBOutlet weak var playView: UIView!
    @IBOutlet weak var downlaodView: UIView!
    
    weak var delegate: DetailsTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpUI()
    }
    
    func setUpUI() {
        closeButton.layer.cornerRadius = 20.0
        watchingView.isHidden = true
        playView.layer.cornerRadius = 5.0
        downlaodView.layer.cornerRadius = 5.0
    }
    
    func configureUI(details: Details?) {
        if let details = details {
            if let url = URL(string: details.imagery?.mobileImg ?? "") {
                contentImageView.sd_setImage(with: url, placeholderImage: nil, options: .highPriority, context: nil)
            }
            
            contentType.text = details.contentType?.uppercased() ?? ""
            year.text = "2020"
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
            if let castArray = details.cast {
                cast.text = getStringFromArray(type: "Cast", array: castArray)
            }else {
                cast.isHidden = true
            }
            if let genreArray = details.genres {
                genre.text = getStringFromArray(type: "Genre", array: genreArray)
            }else {
                genre.isHidden = true
            }
            
            title.text = details.title
            
        }
    }
    
    func getStringFromArray(type: String, array: [String]) -> String {
        let joinedString = array.joined(separator: ", ")
        return type + ": " + joinedString
    }

    @IBAction func closeButton(_ sender: UIButton) {
        delegate?.closeTapped()
    }
    
    @IBAction func playOrResumeTapped(_ sender: UIButton) {
        delegate?.playOrResumeTapped()
    }
    
    @IBAction func downloadTapped(_ sender: UIButton) {
        
    }
}
