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
        
        setupTabs()
        
    }
    
    func setupTabs(){
        let homeTab = Controllers.home.getControllers()
        let homeTabBarItem = UITabBarItem(title: "Home", image: Images.shared.homeUnselected, selectedImage: Images.shared.homeSelected)
        homeTab.tabBarItem = homeTabBarItem
        
        self.viewControllers = [homeTab]
    }
    

    

}
