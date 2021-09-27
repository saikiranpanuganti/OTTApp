//
//  ResetPasswordViewController.swift
//  OTTApp
//
//  Created by pampana ajay on 26/09/21.
//

import UIKit

class ResetPasswordViewController: UIViewController {
    
    @IBOutlet weak var newPasswordTxt:UITextField!
    @IBOutlet weak var confirmPasswordTxt:UITextField!
    
    var emailStr:String = ""
    
    var viewModel:ResetPasswordViewModel = ResetPasswordViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        newPasswordTxt.attributedPlaceholder = NSAttributedString(string: "New Password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        confirmPasswordTxt.attributedPlaceholder = NSAttributedString(string: "Confirm Password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
       
    }
    
    @IBAction func backTapped(){
        self.navigationController?.popViewController(animated: true)
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
    
    @IBAction func submitTapped(){
        
        if let password = newPasswordTxt.text{
            if isValidPassword(password){
                if let confirmPassword = confirmPasswordTxt.text{
                    if password == confirmPassword{
                        viewModel.userResetPassword(email: emailStr, password: password)
                    }else{
                        showAlert(title: "Confirm Password not Matched ", message: "New password and confirm Passed Should be same")
                    }
                }else {
                    showAlert(title: "Confirm Password Required ", message: "Please Reenter password")
                }
            }else {
                showAlert(title: "Password Required ", message: "Please enter password")
            }
        }else {
            showAlert(title: "Invalid Password", message: "Please enter Valid password")
        }
        
    }

}

extension ResetPasswordViewController:ResetPasswordViewModelDelegate{
    func resetPassword(success: Bool, message: String) {
        
        DispatchQueue.main.async {
            
                if success{
                    self.showAlert(title: "Succes", message: message)
                }else{
                    self.showAlert(title: "Error", message: message)
            }
        }
        
    }
    
}
