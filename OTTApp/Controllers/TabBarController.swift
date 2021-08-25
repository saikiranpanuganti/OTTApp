//
//  TabBarController.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 24/08/21.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTabs()
    }
    
    func setUpTabs() {
        let homeTab = Controllers.home.getController()
        let homeTabBarItem = UITabBarItem(title: "Home", image: Images.shared.homeUnSelected, selectedImage: Images.shared.homeSelected)
        homeTab.tabBarItem = homeTabBarItem
        
//        let searchTab = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeTabViewController")
//        let searchTabbarItem = UITabBarItem(title: "Search", image: Images.shared.homeUnSelected, selectedImage: Images.shared.homeSelected)
//        searchTab.tabBarItem = searchTabbarItem
//
//        let comingSoonTab = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeTabViewController")
//        let comingSoonTabBarItem = UITabBarItem(title: "Coming Soon", image: Images.shared.homeUnSelected, selectedImage: Images.shared.homeSelected)
//        comingSoonTab.tabBarItem = comingSoonTabBarItem
//
//        let downloadsTab = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeTabViewController")
//        let downloadsTabBarItem = UITabBarItem(title: "Downloads", image: Images.shared.homeUnSelected, selectedImage: Images.shared.homeSelected)
//        downloadsTab.tabBarItem = downloadsTabBarItem
//
//        let moreTab = Controllers.home.getController()
//        let moreTabBarItem = UITabBarItem(title: "More", image: Images.shared.homeUnSelected, selectedImage: Images.shared.homeSelected)
//        moreTab.tabBarItem = moreTabBarItem
        
        self.viewControllers = [homeTab]
    }
}
