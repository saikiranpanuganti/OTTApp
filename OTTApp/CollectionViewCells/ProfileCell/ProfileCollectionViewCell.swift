//
//  ProfileCollectionViewCell.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 25/02/22.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var profileImageBackground: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var editView: UIView!
    @IBOutlet weak var editImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        editView.isHidden = true
        profileImageBackground.layer.cornerRadius = 10.0
    }
    
    func configureUI(profile: Profile?, editOn: Bool) {
        if let profile = profile {
            profileImage.image = UIImage(named: profile.profileImage ?? "")
            profileName.text = profile.profileName
            editView.isHidden = !editOn
        }
    }
    
    func configureUI(systemImage: String) {
        editView.isHidden = true
        profileName.text = ""
        profileImage.image = UIImage(systemName: systemImage)?.withRenderingMode(.alwaysTemplate)
        profileImage.tintColor = UIColor.white
    }
    
    func configureUI(profile: Profile?, border: UIColor) {
        if let profile = profile {
            profileImage.image = UIImage(named: profile.profileImage ?? "")
            profileName.text = profile.profileName
            profileName.font = UIFont.systemFont(ofSize: 14)
            profileImage.backgroundColor = UIColor.darkGray
            profileImageBackground.layer.borderColor = border.cgColor
            profileImageBackground.layer.borderWidth = 2.0
        }
    }
    
}
