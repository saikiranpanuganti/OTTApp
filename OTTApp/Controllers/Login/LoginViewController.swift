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
        
        viewModel.delegate = self
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        
        registerButton.layer.borderWidth = 2.0
        registerButton.layer.borderColor = UIColor.black.cgColor
        registerButton.layer.cornerRadius = 10.0
        
        loginButton.layer.borderWidth = 2.0
        loginButton.layer.borderColor = UIColor.black.cgColor
        loginButton.layer.cornerRadius = 10.0
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{8,}"
        let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: password)
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okButton)
        self.present(alertController, animated: true, completion: nil)
    }

    @IBAction func loginTapped() {
        
        if let email = emailTextField.text {
            if isValidEmail(email){
            if let password = passwordTextField.text{
                if isValidPassword(password){
                    
                viewModel.loginUser(email: email, password: password)
                    
                }else {
                    showAlert(title: "Invalid Password", message: "Please enter Valid password")
                }
            }else {
                showAlert(title: "Password Required ", message: "Please enter password")
            }
                
            }else {
                showAlert(title: "Invalid Email", message: "Please enter valid Email")
            }
        }else {
            showAlert(title: "Email Requires", message: "Please enter Email")
        
        }
        
        
       // print("Call APi and print response from APi")
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


extension LoginViewController: LoginViewModelDelegate {
    func loginResponse(success: Bool, message: String?) {
        DispatchQueue.main.async {
            if success {
                self.showAlert(title: "Success", message: "User Login Succesfully")
            }else {
                self.showAlert(title: "Error", message:  "Server Error")
            }
        }
    }
}
