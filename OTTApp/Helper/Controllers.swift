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
    
    func getController() -> UIViewController {
        var storyBoardId = ""
        var storyBoardName = ""
        
        switch self {
        case .tabBar:
            storyBoardName = "Main"
            storyBoardId = "TabBarController"
            
//            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController")
        case .home:
            storyBoardName = "Main"
            storyBoardId = "HomeTabViewController"
            
//            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeTabViewController")
            
        }
        
        return UIStoryboard(name: storyBoardName, bundle: nil).instantiateViewController(withIdentifier: storyBoardId)
    }
    
    func printController() {
        print(UIViewController())
    }
}
