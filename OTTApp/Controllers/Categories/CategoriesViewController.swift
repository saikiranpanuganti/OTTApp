//
//  CategoriesViewController.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 01/09/21.
//

import UIKit

protocol CategoriesViewControllerDelegate: AnyObject {
    func homeCategoryTapped(homeTypeString: String)
}

class CategoriesViewController: UIViewController {
    @IBOutlet weak var categoriesView: CategoriesView!
    var viewModel: CategoriesViewModel = CategoriesViewModel()
    
    weak var delegate: CategoriesViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        categoriesView.delegate = self
        categoriesView.category = viewModel.category
        categoriesView.setUpUI()
        viewModel.getData()
    }
    

}

extension CategoriesViewController: CategoriesViewDelegate {
    func homeCategoryTapped(homeType: String) {
        delegate?.homeCategoryTapped(homeTypeString: homeType)
    }
    func closeTapped() {
        print("closetapped")
        dismiss(animated: true, completion: nil)
    }
}

extension CategoriesViewController: CategoriesViewModelDelegate {
    func updateUI() {
        let data = viewModel.categoriesData
        categoriesView.categoriesData = data
        categoriesView.homeCategoriesData = viewModel.homeCategoriesData
        categoriesView.updateUI()
    }
}
