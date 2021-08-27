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
        usersView.setupUI()
       
    }
    

  

}
