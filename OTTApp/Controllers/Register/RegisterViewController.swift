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
    @IBOutlet weak var signInMessage: UILabel!
    @IBOutlet weak var calenderView: CalenderView!
    
    var viewModel: RegisterViewModel = RegisterViewModel()
    var range: NSRange = NSRange()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    
    func setUpUI() {
        calenderView.isHidden = true
        calenderView.delegate = self
        viewModel.delegate = self
        
        dobTextField.delegate = self
        
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
        
        let text = "Sign in is protected by Google reCAPTCHA to ensure you're not a bot. Learn more."
        signInMessage.text = text
        let attributedString = NSMutableAttributedString(string: text)
        range = (text as NSString).range(of: "Learn more.")
        attributedString.addAttribute(NSAttributedString.Key.font, value: Fonts.shared.bold2, range: range)
//        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: Colors.shared.lightGrey, range: range)
        signInMessage.font = Fonts.shared.regular2
        signInMessage.textColor = Colors.shared.lightGrey
        signInMessage.attributedText = attributedString
        signInMessage.isUserInteractionEnabled = true
        signInMessage.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(learnMoreTapped(gesture:))))
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
    func isValidDOB(_ dob: String) -> Bool {
        let dobRegEx = "(0[1-9]|[12][0-9]|3[01])-(0[1-9]|1[012])-((19|20)\\d\\d)"
            
        let dobPred = NSPredicate(format:"SELF MATCHES %@", dobRegEx)
        return dobPred.evaluate(with: dob)
    }

    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default) { action in
            if title == "Success" {
                self.navigateToLoginScren()
            }
        }
        alertController.addAction(okButton)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func navigateToLoginScren() {
        DispatchQueue.main.async {
            let contoller = Controllers.login.getControllers()
            self.navigationController?.pushViewController(contoller, animated: true)
        }
    }

    @IBAction func registerTapped(_ sender: UIButton) {
        if let email = emailTextField.text?.replacingOccurrences(of: " ", with: "") {
            if isValidEmail(email) {
                if let password = passwordTextField.text {
                    if isValidPassword(password) {
                        if let confirmPassword = confirmPasswordTextField.text {
                            if confirmPassword == password {
                                if let dob = dobTextField.text {
                                    if isValidDOB(dob){
                                    viewModel.registerUser(email: email, password: password, dob: dob)
                                    }else{
                                        showAlert(title: "Invalid DOB", message: "Please select date of birth")
                                    }
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
        navigateToLoginScren()
    }
    
    @IBAction func learnMoreTapped(gesture: UITapGestureRecognizer) {
        if gesture.didTapAttributedTextInLabel(label: signInMessage, inRange: range) {
            print("learnMoreTapped")
        }
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

extension RegisterViewController: CalenderViewDelegate {
    func dateSelected(date: Date?) {
        calenderView.isHidden = true
        if let formattedDate = date?.convertToDOBFormat() {
            dobTextField.text = formattedDate
            dobTextField.resignFirstResponder()
        }
        
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        calenderView.isHidden = false
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        calenderView.isHidden = true
    }
}
