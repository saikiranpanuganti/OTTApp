//
//  HomeTabViewController.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 24/08/21.
//

import UIKit

class HomeTabViewController: UIViewController {
    @IBOutlet weak var homeTabView: HomeTabView!
    var viewModel: HomeTabViewModel = HomeTabViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .red
        viewModel.delegate = self
        homeTabView.setUpUI()
        viewModel.getData()
    }

}

extension HomeTabViewController: HomeTabViewModelDelegate {
    func updateUI() {
        let data = viewModel.homeData
        homeTabView.homeData = data
        homeTabView.updateUI()
    }
}
