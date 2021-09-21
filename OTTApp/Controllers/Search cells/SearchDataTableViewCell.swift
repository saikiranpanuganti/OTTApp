//
//  SearchDataTableViewCell.swift
//  OTTApp
//
//  Created by  prasanth kumar on 21/09/21.
//

import UIKit
import SDWebImage

class SearchDataTableViewCell: UITableViewCell {

    @IBOutlet weak var imgRef:UIImageView!
    @IBOutlet weak var movielblRef:UILabel!
    @IBOutlet weak var playBtnImgRef:UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        movielblRef.font = Fonts.shared.medium4
        imgRef.layer.cornerRadius = 08
    }

    func configUI(img:String,mveLbl:String){
        let url = URL(string: img)
        
        imgRef.sd_setImage(with: url, completed: nil)
        movielblRef.text = mveLbl
    }
    
}
