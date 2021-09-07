//
//  LabelTableViewCell.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 01/09/21.
//

import UIKit

class LabelTableViewCell: UITableViewCell {
    @IBOutlet weak var labelOutlet: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpUI()
    }
    
    func setUpUI() {
        labelOutlet.textColor = Colors.shared.whiteColor
    }
    
    func configureUI(text: String, isHeader: Bool) {
        labelOutlet.text = text
        
        if isHeader {
            labelOutlet.font = Fonts.shared.bold6
        }else {
            labelOutlet.font = Fonts.shared.regular4
        }
    }
}
