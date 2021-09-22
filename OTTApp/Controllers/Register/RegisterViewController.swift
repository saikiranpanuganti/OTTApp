//
//  RegisterViewController.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 22/09/21.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    var viewModel: RegisterViewModel = RegisterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        
        registerButton.layer.borderWidth = 2.0
        registerButton.layer.borderColor = UIColor.black.cgColor
        registerButton.layer.cornerRadius = 10.0
        
        signInButton.layer.borderWidth = 2.0
        signInButton.layer.borderColor = UIColor.black.cgColor
        signInButton.layer.cornerRadius = 10.0
        
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        confirmPasswordTextField.attributedPlaceholder = NSAttributedString(string: "Confirm Password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        dobTextField.attributedPlaceholder = NSAttributedString(string: "Date of Birth", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
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

    @IBAction func registerTapped(_ sender: UIButton) {
        if let email = emailTextField.text?.replacingOccurrences(of: " ", with: "") {
            if isValidEmail(email) {
                if let password = passwordTextField.text {
                    if isValidPassword(password) {
                        if let confirmPassword = confirmPasswordTextField.text {
                            if confirmPassword == password {
                                if let dob = dobTextField.text {
                                    viewModel.registerUser(email: email, password: password, dob: dob)
                                }else {
                                    showAlert(title: "Invalid DOB", message: "Please select date of birth")
                                }
                            }else {
                                showAlert(title: "Invalid Confirm Password", message: "Please enter Confirm Password same as Password")
                            }
                        }else {
                            showAlert(title: "Invalid Confirm Password", message: "Please enter Confirm Password")
                        }
                    }else {
                        showAlert(title: "Invalid Password", message: "Please enter a valid password")
                    }
                }else {
                    showAlert(title: "Invalid Password", message: "Please enter password")
                }
            }else {
                showAlert(title: "Invalid Email", message: "Please enter a valid email id")
            }
         }
    }
    
    @IBAction func signInTapped(_ sender: UIButton) {
        
    }
}

extension RegisterViewController: RegisterViewModelDelegate {
    func registrationResponse(success: Bool, message: String?) {
        DispatchQueue.main.async {
            if success {
                self.showAlert(title: "Success", message: "Registration is success. Please Sign In to continue")
            }else {
                self.showAlert(title: "Error", message: message ?? "Server Error")
            }
        }
    }
}
