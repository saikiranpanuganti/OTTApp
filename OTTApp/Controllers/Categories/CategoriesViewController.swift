//
//  CategoriesViewController.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 01/09/21.
//

import UIKit

class CategoriesViewController: UIViewController {
    @IBOutlet weak var categoriesView: CategoriesView!
    var viewModel: CategoriesViewModel = CategoriesViewModel()
    
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
    func closeTapped() {
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
