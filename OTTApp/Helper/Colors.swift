//
//  Colors.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 25/08/21.
//



import UIKit
class Colors {
    
    static let shared : Colors = Colors()
    private init(){ }
    
    let whiteColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1) //(#colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1))
    let blackTextColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) //(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
    let blackViewColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) //(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
    let clear = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) //(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0))
    let menuTopGradientColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.95) //rgba(0, 0, 0, 0.95)
    var menuBottomGradientColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6) //rgba(0, 0, 0, 0.6)
}
