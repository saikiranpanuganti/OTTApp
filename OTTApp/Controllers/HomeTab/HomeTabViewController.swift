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
        homeTabView.category = homeTabViewModel.category
        homeTabView.homeData = data
        homeTabView.tvShowsData = homeTabViewModel.tvShowsData
        homeTabView.moviesData = homeTabViewModel.moviesData
        homeTabView.subCategoryData = homeTabViewModel.subCategoryData
        homeTabView.updateUI()
    }
}

extension HomeTabBarViewController: HomeTabViewDelegate {
    func logoButtonTapped() {
        homeTabViewModel.getData()
    }
    
    func tvButtonTapped() {
        homeTabViewModel.getTvShowsData()
    }
    
    func moviesButtonTapped() {
        homeTabViewModel.getMoviesData()
    }
    
    func homeCategoriesTapped() {
        if let controller = Controllers.categories.getControllers() as? CategoriesViewController {
            controller.delegate = self
            controller.viewModel.category = .home
            controller.modalPresentationStyle = .overFullScreen
            present(controller, animated: true, completion: nil)
        }
    }
    
    func movieSubButtonTapped() {
        if let controller = Controllers.categories.getControllers() as? CategoriesViewController {
            controller.delegate = self
            controller.viewModel.category = .movies
            controller.modalPresentationStyle = .overFullScreen
            present(controller, animated: true, completion: nil)
        }
    }
    
    func tvSubButtonTapped() {
        if let controller = Controllers.categories.getControllers() as? CategoriesViewController {
            controller.delegate = self
            controller.viewModel.category = .tvShows
            controller.modalPresentationStyle = .overFullScreen
            present(controller, animated: true, completion: nil)
        }
    }
}

extension HomeTabBarViewController: CategoriesViewControllerDelegate {
    func movieSubCategoryTapped(subCategory: String) {
        homeTabViewModel.movieSubCategoryTapped(subCategory: subCategory)
    }
    
    func tvShowsSubCategoryTapped(subCategory: String) {
        homeTabViewModel.tvShowsSubCategoryTapped(subCategory: subCategory)
    }
    
    func homeCategoryTapped(homeTypeString: String) {
        homeTabView.updateMenuView(selectedItem: homeTypeString)
        
        if homeTypeString == "Movies" {
            homeTabViewModel.getMoviesData()
        }else if homeTypeString == "TV Shows" {
            homeTabViewModel.getTvShowsData()
        }else if homeTypeString == "Home" {
            homeTabViewModel.getData()
        }else if homeTypeString == "My List" {
            
        }
    }
}
