//
//  SplashViewController.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 27/09/21.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkLoggedStatus()
    }
    
    func checkLoggedStatus() {
        if let isLoggedIn = UserDefaults.standard.value(forKey: kLoggedIn) as? Bool {
            if isLoggedIn {
                let controller = Controllers.users.getControllers()
                navigationController?.viewControllers = [controller]
            }else {
                let controller = Controllers.login.getControllers()
                navigationController?.viewControllers = [controller]
            }
        }else {
            let controller = Controllers.login.getControllers()
            navigationController?.viewControllers = [controller]
        }
    }

}
