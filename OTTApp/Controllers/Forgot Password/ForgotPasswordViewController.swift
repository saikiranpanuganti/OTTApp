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
    @IBOutlet weak var calenderView: CalenderView!
    
    var viewModel: ForgotPasswordViewModel = ForgotPasswordViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calenderView.delegate = self
        dobTextField.delegate = self
        calenderView.isHidden = true
        viewModel.delegate = self
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        dobTextField.attributedPlaceholder = NSAttributedString(string: "Date of Birth", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        
        submitButton.backgroundColor = UIColor.red
        submitButton.layer.cornerRadius = 5.0
    }
    
    @IBAction func backTapped(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidDOB(_ dob: String) -> Bool {
        let dobRegEx = "(0[1-9]|[12][0-9]|3[01])-(0[1-9]|1[012])-((19|20)\\d\\d)"
            
        let dobPred = NSPredicate(format:"SELF MATCHES %@", dobRegEx)
        return dobPred.evaluate(with: dob)
    }
    

    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okButton)
        self.present(alertController, animated: true, completion: nil)
    }

    @IBAction func submitTapped() {
        
        if let email = emailTextField.text{
            if isValidEmail(email){
                if let dob = dobTextField.text{
                    if isValidDOB(dob){
                        viewModel.userForgotPassword(email: email, dob: dob)
                                     
                    }else{
                        showAlert(title: "Invalid DOB", message: "Please enter Valid DOB")
                    }
                }else{
                    showAlert(title: "DOB Required", message: "Please enter DOB")
                }
            }else{
                showAlert(title: "Invalid Email", message: "Please valid enter Email")
            }
            
        }else{
            showAlert(title: "Email Required", message: "Please enter Email")
        }
    
    }
}

extension ForgotPasswordViewController:ForgotPasswordViewModelDelegate{
    func forgotPassword(dobVerified: Bool, message: String) {
       
        DispatchQueue.main.async {
            if dobVerified{
               
                let alertController = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
             
                let okButton = UIAlertAction(title: "OK", style: .cancel) { bool in
                    
                    if let vc = Controllers.resetPassword.getControllers() as? ResetPasswordViewController
                  {
                    vc.emailStr = self.emailTextField.text ?? ""
                    self.navigationController?.pushViewController(vc, animated: true)
                  }
                }
                alertController.addAction(okButton)
                self.present(alertController, animated: true, completion: nil)
                
                
            }
            else{
                
                self.showAlert(title: "Error", message: message)
            }
        }
        
    }
    
}

extension ForgotPasswordViewController:CalenderViewDelegate{
    func dateSelected(date: Date?) {
        calenderView.isHidden = true
      if  let dateFormatter = date?.convertToDOBFormat(){
        dobTextField.text = dateFormatter
        }
        dobTextField.resignFirstResponder()
    }

}
extension ForgotPasswordViewController:UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        calenderView.isHidden = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        calenderView.isHidden = true
    }
    
    
    
}
