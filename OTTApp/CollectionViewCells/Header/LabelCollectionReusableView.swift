//
//  LabelCollectionReusableView.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 25/08/21.
//

import UIKit

class LabelCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var title:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    func setupUI(){
        title.font = Fonts.shared.bold5
        title.textColor = Colors.shared.whiteColor
    }
    
    func configUI(title:String){
        self.title.text = title
    }
    
}
