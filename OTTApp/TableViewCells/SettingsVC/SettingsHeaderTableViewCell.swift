//
//  SettingsHeaderTableViewCell.swift
//  OTTApp
//
//  Created by  prasanth kumar on 29/09/21.
//

import UIKit

class SettingsHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var headerLblRef:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configUI(header:String){
        headerLblRef.text = header
    }
    
}

