//
//  MainImageViewCell.swift
//  OTTApp
//
//  Created by pampana ajay on 27/08/21.
//

import UIKit
import SDWebImage

protocol MainImageViewCellDelegate: AnyObject {
    func myListTapped()
    func infoTapped()
    func playTapped()
}

class MainImageViewCell: UICollectionViewCell {

    @IBOutlet weak var playBtnView:UIView!
    @IBOutlet weak var imageRef:UIImageView!
    
    weak var delegate: MainImageViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        playBtnView.layer.cornerRadius = 5
    }
    
    func configUI(img:String){
        let url = URL(string: img)
        
        imageRef.sd_setImage(with: url, completed: nil)
    }

    @IBAction func myListTapped(_ sender: UIButton) {
        delegate?.myListTapped()
    }
    
    @IBAction func infoTapped(_ sender: UIButton) {
        delegate?.infoTapped()
    }
    
    @IBAction func playTapped(_ sender: UIButton) {
        delegate?.playTapped()
    }
}
