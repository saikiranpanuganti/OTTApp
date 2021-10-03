//
//  DetailsView.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 14/09/21.
//

import UIKit

protocol DetailsViewDelegate: AnyObject {
    func closeTapped()
    func playOrResumeTapped()
}

class DetailsView: UIView {
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: DetailsViewDelegate?
    var details: Details?
    var showEpisodes: Bool = true
    var moreLikeThisData: MoreLikeThisModel?
    
    func setUpUI() {
        tableView.register(UINib(nibName: "DetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailsTableViewCell")
        tableView.register(UINib(nibName: "DetailsHeaderTableViewCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "DetailsHeaderTableViewCell")
        tableView.register(UINib(nibName: "EpisodeTableViewCell", bundle: nil), forCellReuseIdentifier: "EpisodeTableViewCell")
        tableView.register(UINib(nibName: "MoreLikeThisTableViewCell", bundle: nil), forCellReuseIdentifier: "MoreLikeThisTableViewCell")
        
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
            if showEpisodes {
                return details?.seasons?.first?.episodes?.count ?? 0
            }else {
                return 1
            }
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
            if showEpisodes {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeTableViewCell", for: indexPath) as? EpisodeTableViewCell {
                    cell.configureUI(episode: details?.seasons?.first?.episodes?[indexPath.row])
                    cell.delegate = self
                    return cell
                }
            }else {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "MoreLikeThisTableViewCell", for: indexPath) as? MoreLikeThisTableViewCell {
                    cell.configureUI(data: moreLikeThisData)
                    return cell
                }
            }
        }
        
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "DetailsHeaderTableViewCell") as? DetailsHeaderTableViewCell {
                header.configureUI(season: details?.seasons?.first)
                header.delegate = self
                return header
            }
        }
        return UIView()
    }
}

extension DetailsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 && !showEpisodes {
            return ((screenWidth-8)/2)*4
        }
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
    func playOrResumeTapped() {
        delegate?.playOrResumeTapped()
    }
    
    func closeTapped() {
        delegate?.closeTapped()
    }
}

extension DetailsView: EpisodeTableViewCellDelegate {
    
}

extension DetailsView: DetailsHeaderTableViewCellDelegate {
    func episodestapped() {
        showEpisodes = true
        updateUI()
    }
    
    func moreLikeThistapped() {
        showEpisodes = false
        updateUI()
    }
    
    func seasonTapped() {
        
    }
}
