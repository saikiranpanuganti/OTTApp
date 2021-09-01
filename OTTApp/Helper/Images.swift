//
//  Images.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 24/08/21.
//

import UIKit

class Images {
    
   static let shared :Images = Images()
    private init() { }
    
    let homeUnselected = UIImage(named: "Home")
    let homeSelected = UIImage(named: "HomeTap")
    let userImage = UIImage(named: "imageee")
    let netflixLogo = UIImage(named: "netflixLogo")
    let downArrow = UIImage(named: "down-arrow")
    let cast = UIImage(named: "cast")
    let close = UIImage(systemName: "xmark.circle.fill")
}
