//
//  UsersViewController.swift
//  OTTApp
//
//  Created by pampana ajay on 27/08/21.
//

import UIKit

class UsersViewController: UIViewController {
    
    @IBOutlet weak var usersView:UsersView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Loading UsersViewController")
        usersView.delegate = self
        usersView.setupUI()
    }
    
}

extension UsersViewController: UsersViewDelegate {
    func userTapped() {
        let controller = Controllers.tabBar.getControllers()
        navigationController?.viewControllers = [controller]
    }
}
