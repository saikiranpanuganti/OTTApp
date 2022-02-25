//
//  ImageCollectionViewCell.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 24/08/21.
//

import UIKit
import SDWebImage

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var images:UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
      
        images.layer.cornerRadius = 8
    }
    func configUI(urlString:String){
        let url = URL(string: urlString)
        
        images.sd_setImage(with: url, completed: nil)
    }

    func configureUI(image: String) {
        images.image = UIImage(named: image)
        images.backgroundColor = UIColor.darkGray
    }
    
    func configureUI(systemImage: String) {
        images.image = UIImage(systemName: systemImage)
    }
}
