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
        tableView.register(UINib(nibName: "DetailsHeaderTableViewCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "DetailsHeaderTableViewCell")
        tableView.register(UINib(nibName: "EpisodeTableViewCell", bundle: nil), forCellReuseIdentifier: "EpisodeTableViewCell")
        
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
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else {
            return details?.seasons?.first?.episodes?.count ?? 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsTableViewCell", for: indexPath) as? DetailsTableViewCell {
                cell.configureUI(details: details)
                cell.delegate = self
                return cell
            }
        }else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeTableViewCell", for: indexPath) as? EpisodeTableViewCell {
                cell.configureUI(episode: details?.seasons?.first?.episodes?[indexPath.row])
                cell.delegate = self
                return cell
            }
        }
        
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "DetailsHeaderTableViewCell") as? DetailsHeaderTableViewCell {
                header.configureUI(season: details?.seasons?.first)
                return header
            }
        }
        return UIView()
    }
}

extension DetailsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 110
        }
        return 0
    }
}

extension DetailsView: DetailsTableViewCellDelegate {
    func closeTapped() {
        delegate?.closeTapped()
    }
}

extension DetailsView: EpisodeTableViewCellDelegate {
    
}
