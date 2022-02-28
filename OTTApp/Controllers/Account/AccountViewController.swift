//
//  AccountViewController.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 27/02/22.
//

import UIKit

class AccountViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    var profiles = User.shared.savedUser?.profiles ?? []

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(UINib(nibName: "ProfileCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProfileCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        tableView.register(UINib(nibName: "MobileDataUsageTableViewCell", bundle: nil), forCellReuseIdentifier: "MobileDataUsageTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }

    @IBAction func signOutTapped() {
        let controller = Controllers.login.getControllers()
        navigationController?.viewControllers = [controller]
        navigationController?.popToRootViewController(animated: true)
    }
}

extension AccountViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profiles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionViewCell", for: indexPath) as? ProfileCollectionViewCell {
            if User.shared.selectedProfile?.profileID == profiles[indexPath.row].profileID {
                cell.configureUI(profile: profiles[indexPath.row], border: UIColor.white)
            }else {
                cell.configureUI(profile: profiles[indexPath.row], border: UIColor.clear)
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    
}

extension AccountViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if profiles.count == 1 {
            return UIEdgeInsets(top: 0, left: 160, bottom: 0, right: 0)
        }else if profiles.count == 2 {
            return UIEdgeInsets(top: 0, left: 100, bottom: 0, right: 0)
        }else {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
}

extension AccountViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width-60)/5, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}

extension AccountViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MobileDataUsageTableViewCell", for: indexPath) as? MobileDataUsageTableViewCell {
            if indexPath.row == 0 {
                cell.configUI(mobileData: "Notifications", automatic: "", image: "bell")
            }else if indexPath.row == 1 {
                cell.configUI(mobileData: "My List", automatic: "", image: "list.bullet")
            }else if indexPath.row == 2 {
                cell.configUI(mobileData: "App Settings", automatic: "", image: "gearshape")
            }else if indexPath.row == 3 {
                cell.configUI(mobileData: "Devices", automatic: "", image: "iphone.smartbatterycase.gen1")
            }else if indexPath.row == 4 {
                cell.configUI(mobileData: "Help", automatic: "", image: "questionmark.circle")
            }
            return cell
        }
        return UITableViewCell()
    }
}

extension AccountViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

