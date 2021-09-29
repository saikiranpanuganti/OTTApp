//
//  MobileDataUsageTableViewCell.swift
//  OTTApp
//
//  Created by  prasanth kumar on 28/09/21.
//

import UIKit

class MobileDataUsageTableViewCell: UITableViewCell {

    @IBOutlet weak var mobileDataUsageLblRef:UILabel!
    @IBOutlet weak var automaticLblRef:UILabel!
    @IBOutlet weak var topHeightMobilefdata:NSLayoutConstraint!
    @IBOutlet weak var iconImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configUI(mobileData:String,automatic:String, image: String){
        mobileDataUsageLblRef.text = mobileData
        automaticLblRef.text = automatic
        iconImage.image = UIImage(systemName: image)
    }
     
    
}
