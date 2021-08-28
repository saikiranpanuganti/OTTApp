//
//  HomeTabViewController.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 24/08/21.
//

import UIKit

class HomeTabBarViewController: UIViewController {
    
    @IBOutlet weak var homeTabView:HomeTabView!
    var homeTabViewModel:HomeTabViewModel = HomeTabViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeTabViewModel.delegate = self
        homeTabView.setupUI()
        homeTabView.addGradientView()
        homeTabView.updateUI()
        homeTabViewModel.getData()
        
    }
}

extension HomeTabBarViewController:HomeTabViewModelDeleagte{
    func updateUI() {
        let data = homeTabViewModel.homeData
        homeTabView.homeData = data
        homeTabView.updateUI()
    }
    
    
}
