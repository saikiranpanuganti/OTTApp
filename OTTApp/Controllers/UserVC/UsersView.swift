//
//  UsersView.swift
//  OTTApp
//
//  Created by pampana ajay on 27/08/21.
//

import UIKit

class UsersView:UIView{
    
    @IBOutlet weak var userOneImg:UIImageView!
    @IBOutlet weak var userTwoImg:UIImageView!
    @IBOutlet weak var userThreeImg:UIImageView!
    @IBOutlet weak var userFourImg:UIImageView!
    @IBOutlet weak var userFiveImg:UIImageView!
    
    @IBOutlet weak var userOneLbl:UILabel!
    @IBOutlet weak var userTwoLbl:UILabel!
    @IBOutlet weak var userThreeLbl:UILabel!
    @IBOutlet weak var userFourLbl:UILabel!
    @IBOutlet weak var userFiveLbl:UILabel!
    
    @IBOutlet weak var UserOneView:UIImageView!
    @IBOutlet weak var UserTwoView:UIImageView!
    @IBOutlet weak var UserThreeView:UIImageView!
    @IBOutlet weak var UserFourView:UIImageView!
    @IBOutlet weak var UserFiveView:UIImageView!
    
    func setupUI(){
        userOneImg.image = Images.shared.userImage
        userTwoImg.image = Images.shared.userImage
        userThreeImg.image = Images.shared.userImage
        userFourImg.image = Images.shared.userImage
        userFiveImg.image = Images.shared.userImage
        
        UserOneView.layer.cornerRadius = 8
        UserTwoView.layer.cornerRadius = 8
        UserThreeView.layer.cornerRadius = 8
        UserFourView.layer.cornerRadius = 8
        UserFiveView.layer.cornerRadius = 8
        
        userOneLbl.text = "User 1"
        userTwoLbl.text = "User 2"
        userThreeLbl.text = "User 3"
        userFourLbl.text = "User 4"
        userFiveLbl.text = "User 5"
        
        userOneLbl.font = Fonts.shared.medium5
        userTwoLbl.font = Fonts.shared.medium5
        userThreeLbl.font = Fonts.shared.medium5
        userFourLbl.font = Fonts.shared.medium5
        userFiveLbl.font = Fonts.shared.medium5
        
        userOneLbl.textColor = Colors.shared.whiteColor
        userTwoLbl.textColor = Colors.shared.whiteColor
        userThreeLbl.textColor = Colors.shared.whiteColor
        userFourLbl.textColor = Colors.shared.whiteColor
        userFiveLbl.textColor = Colors.shared.whiteColor
        
        
        
        
        
    }
    
}
