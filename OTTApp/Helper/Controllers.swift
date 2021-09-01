//
//  Controllers.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 24/08/21.
//

import UIKit
enum Controllers {
    case tabBar
    case home
    case users
    case categories
    
    func getControllers()->UIViewController{
        var storyBoardName = ""
        var storyBoardID = ""
        switch self {
        case .tabBar:
            storyBoardName = "Main"
            storyBoardID = "TabBarController"
        case .home :
            storyBoardName = "Main"
            storyBoardID = "HomeTabBarViewController"
        case .users:
            storyBoardName = "Main"
            storyBoardID = "UsersViewController"
        case .categories:
            storyBoardName = "Home"
            storyBoardID = "CategoriesViewController"
        }
        return UIStoryboard(name: storyBoardName, bundle: nil).instantiateViewController(withIdentifier: storyBoardID)
        
    }
    
    
    
}
