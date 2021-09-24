//
//  LoginViewController.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 24/09/21.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!

    var viewModel: LoginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }
    
    func setUpUI() {
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        
        registerButton.layer.borderWidth = 2.0
        registerButton.layer.borderColor = UIColor.black.cgColor
        registerButton.layer.cornerRadius = 10.0
        
        loginButton.layer.borderWidth = 2.0
        loginButton.layer.borderColor = UIColor.black.cgColor
        loginButton.layer.cornerRadius = 10.0
    }

    @IBAction func loginTapped() {
        print("Call APi and print response from APi")
    }
    
    @IBAction func registerTapped() {
        let controller = Controllers.register.getControllers()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func forgotPassword() {
        let controller = Controllers.forgotPassword.getControllers()
        navigationController?.pushViewController(controller, animated: true)
    }
}
