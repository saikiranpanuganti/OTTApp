//
//  SettingsTabViewController.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 28/09/21.
//

import UIKit

class SettingsTabViewController: UIViewController {

    @IBOutlet weak var tableViewRef:UITableView!
    @IBOutlet weak var navBar: UIView!
    @IBOutlet weak var navBarHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    
    func setUpUI(){
        tableViewRef.delegate = self
        tableViewRef.dataSource = self
        tableViewRef.register(UINib(nibName: "MobileDataUsageTableViewCell", bundle: nil), forCellReuseIdentifier: "MobileDataUsageTableViewCell")
        tableViewRef.register(UINib(nibName: "WifiOnlyTableViewCell", bundle: nil), forCellReuseIdentifier: "WifiOnlyTableViewCell")
        tableViewRef.register(UINib(nibName: "SettingsHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingsHeaderTableViewCell")
        tableViewRef.register(UINib(nibName: "MemoryCalculationTableViewCell", bundle: nil), forCellReuseIdentifier: "MemoryCalculationTableViewCell")
        
        navBarHeight.constant = topSafeArea + 40
    }

    func openSpeedTestUrl() {
        if let url = URL(string: "https://fast.com/") {
            UIApplication.shared.open(url)
        }
    }
    
    func openWebKit() {
        let controller = Controllers.webView.getControllers()
        navigationController?.pushViewController(controller, animated: true)
    }
}
extension SettingsTabViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 3
        case 2:
            return 2
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if let vc = tableViewRef.dequeueReusableCell(withIdentifier: "MobileDataUsageTableViewCell", for: indexPath) as? MobileDataUsageTableViewCell {
                return vc
            }
        case 1:
            switch indexPath.row {
            case 0:
                if let vc = tableViewRef.dequeueReusableCell(withIdentifier: "WifiOnlyTableViewCell", for: indexPath) as? WifiOnlyTableViewCell {
                    return vc
                }
            case 1:
                if let vc = tableViewRef.dequeueReusableCell(withIdentifier: "MobileDataUsageTableViewCell", for: indexPath) as? MobileDataUsageTableViewCell {
                    vc.configUI(mobileData: "Video Quality", automatic: "Standard", image: "airplayvideo")
                    return vc
                }
            case 2:
                if let vc = tableViewRef.dequeueReusableCell(withIdentifier: "MemoryCalculationTableViewCell", for: indexPath) as? MemoryCalculationTableViewCell {
                    return vc
                }
            default:break
                
            }
        case 2:
            switch indexPath.row {
            case 0:
                if let vc = tableViewRef.dequeueReusableCell(withIdentifier: "MobileDataUsageTableViewCell", for: indexPath) as? MobileDataUsageTableViewCell {
                    vc.automaticLblRef.isHidden = true
                    vc.configUI(mobileData: "Internet speed test", automatic: "", image: "speedometer")
                    vc.topHeightMobilefdata.constant = 30
                    return vc
                }
            case 1:
                if let vc = tableViewRef.dequeueReusableCell(withIdentifier: "MobileDataUsageTableViewCell", for: indexPath) as? MobileDataUsageTableViewCell {
                    vc.automaticLblRef.isHidden = true
                    vc.configUI(mobileData: "Privacy Policy", automatic: "", image: "doc")
                    vc.topHeightMobilefdata.constant = 30
                    return vc
                }
            default:
                break
            }
        default:
            break
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let header = tableViewRef.dequeueReusableCell(withIdentifier: "SettingsHeaderTableViewCell") as? SettingsHeaderTableViewCell {
            switch section {
            case 0:
                header.configUI(header: "Video Playback")
            case 1:
                header.configUI(header: "Downloads")
            case 2:
                header.configUI(header: "About")
            default:
                break
            }
            return header
        }
        return UIView()
    }
}
extension SettingsTabViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            if indexPath.row == 0 {
                openSpeedTestUrl()
            }else if indexPath.row == 1 {
                openWebKit()
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 80
        case 1:
            switch indexPath.row {
            case 0:
                return 160
            case 1:
                return 80
            case 2:
                return 145
            default:
                break
            }
        case 2:
            return 60
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
}

