//
//  ProfileViewController.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 23/02/22.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var createButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        createButton.backgroundColor = UIColor.red
        createButton.layer.cornerRadius = 5.0
        
    }

    @IBAction func createProfileTapped(_ sender: UIButton) {
        print("Create profile Tapped")
    }
}
