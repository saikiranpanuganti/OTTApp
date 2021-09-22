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
    
    let homeUnselected = UIImage(named: "Home")?.withTintColor(.lightGray, renderingMode: .alwaysTemplate)
    let homeSelected = UIImage(named: "Home")?.withTintColor(.white, renderingMode: .alwaysTemplate)
    let searchUnSelected = UIImage(systemName: "magnifyingglass")?.withTintColor(.lightGray, renderingMode: .alwaysTemplate)
    let searchSelected = UIImage(systemName: "magnifyingglass")?.withTintColor(.white, renderingMode: .alwaysTemplate)
    let userImage = UIImage(named: "imageee")
    let netflixLogo = UIImage(named: "netflixLogo")
    let downArrow = UIImage(named: "down-arrow")
    let cast = UIImage(named: "cast")
    let close = UIImage(systemName: "xmark.circle.fill")
    let netflix = UIImage(named: "netflix")
}
