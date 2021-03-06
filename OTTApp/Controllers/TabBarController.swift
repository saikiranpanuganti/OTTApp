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
        tabBar.barTintColor = UIColor.black
    }
    
    func setupTabs(){
        let homeTab = Controllers.home.getControllers()
        let homeTabBarItem = UITabBarItem(title: "Home", image: Images.shared.homeUnselected?.withRenderingMode(.alwaysTemplate), selectedImage: Images.shared.homeSelected?.withRenderingMode(.alwaysTemplate))
        homeTab.tabBarItem = homeTabBarItem
        
        let searchTab = Controllers.searchTab.getControllers()
        let searchTabBarItem = UITabBarItem(title: "Search", image: Images.shared.searchUnSelected?.withRenderingMode(.alwaysTemplate), selectedImage: Images.shared.searchSelected?.withRenderingMode(.alwaysTemplate))
        searchTab.tabBarItem = searchTabBarItem
        
        let settingsTab = Controllers.settingsTab.getControllers()
        let settingsTabBarItem = UITabBarItem(title: "Settings", image: Images.shared.settingsUnSelected?.withRenderingMode(.alwaysTemplate), selectedImage: Images.shared.settingsSelected?.withRenderingMode(.alwaysTemplate))
        settingsTab.tabBarItem = settingsTabBarItem
        
        let accountTab = Controllers.account.getControllers()
        let accountTabBarItem = UITabBarItem(title: "Account", image: UIImage(systemName: "person.circle"), selectedImage: UIImage(systemName: "person.circle.fill"))
        accountTab.tabBarItem = accountTabBarItem
        
        self.viewControllers = [homeTab, searchTab, accountTab, settingsTab]
    }

}
