//
//  DetailsViewController.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 14/09/21.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var detailsView: DetailsView!
    var viewModel: DetailsViewModel = DetailsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        detailsView.setUpUI()
        viewModel.getData()
    }

}

extension DetailsViewController: DetailsViewModelDelegate {
    func updateUI() {
        
    }
}
