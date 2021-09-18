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

        detailsView.delegate = self
        viewModel.delegate = self
        detailsView.setUpUI()
        viewModel.getData()
    }

}

extension DetailsViewController: DetailsViewModelDelegate {
    func updateUI() {
        let details = viewModel.details
        detailsView.details = details
        detailsView.moreLikeThisData = viewModel.moreLikeThisData
        detailsView.updateUI()
    }
}

extension DetailsViewController: DetailsViewDelegate {
    func closeTapped() {
        dismiss(animated: true, completion: nil)
    }
}
