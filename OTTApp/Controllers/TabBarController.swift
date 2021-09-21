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
        setUpTabBarView()
    }
    
    func setUpTabBarView() {
        tabBar.tintColor = UIColor.white
    }
    
    func setupTabs(){
        let homeTab = Controllers.home.getControllers()
        let homeTabBarItem = UITabBarItem(title: "Home", image: Images.shared.homeUnselected?.withRenderingMode(.alwaysTemplate), selectedImage: Images.shared.homeSelected?.withRenderingMode(.alwaysTemplate))
        homeTab.tabBarItem = homeTabBarItem
        
        let searchTab = Controllers.searchTab.getControllers()
        let searchTabBarItem = UITabBarItem(title: "Search", image: Images.shared.searchUnSelected?.withRenderingMode(.alwaysTemplate), selectedImage: Images.shared.searchSelected?.withRenderingMode(.alwaysTemplate))
        searchTab.tabBarItem = searchTabBarItem
        
        self.viewControllers = [homeTab, searchTab]
    }
    

    

}
