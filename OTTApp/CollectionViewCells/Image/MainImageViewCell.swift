//
//  MainImageViewCell.swift
//  OTTApp
//
//  Created by pampana ajay on 27/08/21.
//

import UIKit
import SDWebImage

class MainImageViewCell: UICollectionViewCell {

    @IBOutlet weak var playBtnView:UIView!
    @IBOutlet weak var imageRef:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        playBtnView.layer.cornerRadius = 5
    }
    
    func configUI(img:String){
        let url = URL(string: img)
        
        imageRef.sd_setImage(with: url, completed: nil)
    }

}
