//
//  LabelCollectionReusableView.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 25/08/21.
//

import UIKit

class LabelCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    func setUpUI() {
        title.font = Fonts.shared.bold4
        title.textColor = Colors.shared.whiteTextColor
    }
    
    func configureUI(headerTitle: String) {
        title.text = headerTitle
    }
}
