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
        
        homeTabView.delegate = self
        homeTabViewModel.delegate = self
        homeTabView.setupUI()
        homeTabView.addGradientView()
        homeTabView.updateUI()
        homeTabViewModel.getData()
        
    }
}

extension HomeTabBarViewController: HomeTabViewModelDeleagte{
    func updateUI() {
        let data = homeTabViewModel.homeData
        homeTabView.homeData = data
        homeTabView.updateUI()
    }
}

extension HomeTabBarViewController: HomeTabViewDelegate {
    func homeCategoriesTapped() {
        if let controller = Controllers.categories.getControllers() as? CategoriesViewController {
            controller.viewModel.category = .home
            controller.modalPresentationStyle = .overFullScreen
            present(controller, animated: true, completion: nil)
        }
    }
    
    func movieSubButtonTapped() {
        if let controller = Controllers.categories.getControllers() as? CategoriesViewController {
            controller.viewModel.category = .movies
            controller.modalPresentationStyle = .overFullScreen
            present(controller, animated: true, completion: nil)
        }
    }
    
    func tvSubButtonTapped() {
        if let controller = Controllers.categories.getControllers() as? CategoriesViewController {
            controller.viewModel.category = .tvShows
            controller.modalPresentationStyle = .overFullScreen
            present(controller, animated: true, completion: nil)
        }
    }
}
