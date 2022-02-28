//
//  DetailsHeaderTableViewCell.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 16/09/21.
//

import UIKit

protocol DetailsHeaderTableViewCellDelegate: AnyObject {
    func episodestapped()
    func moreLikeThistapped()
    func seasonTapped()
}

class DetailsHeaderTableViewCell: UITableViewCell {
    @IBOutlet var episodeViewWidth: NSLayoutConstraint!
    @IBOutlet var moreLikeThisViewWidth: NSLayoutConstraint!
    @IBOutlet var trailersViewWidth: NSLayoutConstraint!
    @IBOutlet weak var episodesLabel: UILabel!
    @IBOutlet weak var moreLikeThisLabel: UILabel!
    @IBOutlet weak var trailersLabel: UILabel!
    @IBOutlet weak var episodesView: UIView!
    @IBOutlet weak var moreLikeThisView: UIView!
    @IBOutlet weak var trailersView: UIView!
    @IBOutlet weak var seasonLabel: UILabel!

    
    weak var delegate: DetailsHeaderTableViewCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpUI()
    }

    func setUpUI() {
        moreLikeThisViewWidth.isActive = false
        moreLikeThisViewWidth.constant = 0
        moreLikeThisViewWidth.isActive = true
        
        trailersViewWidth.isActive = false
        trailersViewWidth.constant = 0
        trailersViewWidth.isActive = true
    }
    
    func configureUI(season: Season?) {
        if let season = season {
            episodesLabel.isHidden = false
            episodesView.isHidden = false
            seasonLabel.text = "Season " + String(season.seasonNumber ?? 1)
        }else {
            episodesLabel.isHidden = true
            episodesView.isHidden = true
        }
    }
    
    @IBAction func episodestapped(_ sender: UIButton) {
        self.trailersViewWidth.isActive = false
        self.trailersViewWidth.constant = 0
        self.trailersViewWidth.isActive = true
        
        self.moreLikeThisViewWidth.isActive = false
        self.moreLikeThisViewWidth.constant = 0
        self.moreLikeThisViewWidth.isActive = true
        
        self.episodeViewWidth.isActive = false
        self.episodeViewWidth.constant = self.episodesLabel.frame.width
        self.episodeViewWidth.isActive = true
    
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        } completion: { bool in
            self.delegate?.episodestapped()
        }
    }
    
    @IBAction func trailerstapped(_ sender: UIButton) {
        self.trailersViewWidth.isActive = false
        self.trailersViewWidth.constant = self.trailersLabel.frame.width
        self.trailersViewWidth.isActive = true
        
        self.moreLikeThisViewWidth.isActive = false
        self.moreLikeThisViewWidth.constant = 0
        self.moreLikeThisViewWidth.isActive = true
        
        self.episodeViewWidth.isActive = false
        self.episodeViewWidth.constant = 0
        self.episodeViewWidth.isActive = true
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        } completion: { bool in
            self.delegate?.episodestapped()
        }
    }
    
    @IBAction func moreLikeThistapped(_ sender: UIButton) {
        self.trailersViewWidth.isActive = false
        self.trailersViewWidth.constant = 0
        self.trailersViewWidth.isActive = true
        
        self.episodeViewWidth.isActive = false
        self.episodeViewWidth.constant = 0
        self.episodeViewWidth.isActive = true
        
        self.layoutIfNeeded()
        
        self.moreLikeThisViewWidth.isActive = false
        self.moreLikeThisViewWidth.constant = self.moreLikeThisLabel.frame.width
        self.moreLikeThisViewWidth.isActive = true
  
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        } completion: { bool in
            self.delegate?.moreLikeThistapped()
        }
    }
    
    @IBAction func seasonTapped(_ sender: UIButton) {
        delegate?.seasonTapped()
    }
}
