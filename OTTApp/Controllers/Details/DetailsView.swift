//
//  DetailsView.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 14/09/21.
//

import UIKit

protocol DetailsViewDelegate: AnyObject {
    func closeTapped()
}

class DetailsView: UIView {
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: DetailsViewDelegate?
    var details: Details?
    
    func setUpUI() {
        tableView.register(UINib(nibName: "DetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailsTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func updateUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension DetailsView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsTableViewCell", for: indexPath) as? DetailsTableViewCell {
            cell.configureUI(details: details)
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
}

extension DetailsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension DetailsView: DetailsTableViewCellDelegate {
    func closeTapped() {
        delegate?.closeTapped()
    }
}
