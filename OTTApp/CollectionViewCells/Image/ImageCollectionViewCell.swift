//
//  ImageCollectionViewCell.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 24/08/21.
//

import UIKit
import SDWebImage

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageOutlet: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func configureUI(urlString: String) {
        imageOutlet.sd_setImage(with: URL(string: urlString), placeholderImage: Images.shared.placeHolder, options: .highPriority, progress: nil, completed: nil)
    }
}
