//
//  ForgotPasswordViewController.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 24/09/21.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    var viewModel: ForgotPasswordViewModel = ForgotPasswordViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        dobTextField.attributedPlaceholder = NSAttributedString(string: "Date of Birth", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        
        submitButton.layer.borderWidth = 2.0
        submitButton.layer.borderColor = UIColor.black.cgColor
        submitButton.layer.cornerRadius = 10.0
    }

    @IBAction func submitTapped() {
        print("Submit Tapped")
    }
}
