//
//  ProfileViewController.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 23/02/22.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var viewCenterY: NSLayoutConstraint!
    @IBOutlet weak var closeButton: UIButton!

    var createProfileTitle = "Please create a profile to continue"
    var isFromLogin: Bool = true
    var imageName: String = "profile18" {
        didSet {
            profileImage.image = UIImage(named: imageName)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createButton.backgroundColor = UIColor.red
        createButton.layer.cornerRadius = 5.0
        
        profileView.layer.cornerRadius = 8.0
        profileImage.image = UIImage(named: imageName)
        
        if User.shared.savedUser?.profiles == nil {
            titleLabel.text = createProfileTitle
            viewCenterY.constant = 0
        }
        
        nameTextfield.attributedPlaceholder = NSAttributedString(string: "Enter profile name", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        
        if isFromLogin {
            closeButton.isHidden = true
        }
    }
    
    func createProfile() {
        if let profileName = nameTextfield.text, profileName.replacingOccurrences(of: " ", with: "") != "" {
            let urlString = "https://n6lih99291.execute-api.ap-south-1.amazonaws.com/dev/update-user"
            
            var headers: [String: String] = [:]
            headers["Content-Type"] = "application/json"
            
            var bodyParams: [String: Any] = [:]
            bodyParams["email"] = User.shared.savedUser?.email ?? ""
            bodyParams["profile"] = ["profileName": profileName, "profileImage": imageName]
            
            NetworkAdaptor.request(url: urlString, method: .put, headers: headers, urlParameters: nil, bodyParameters: bodyParams) { data, response, error in
                if error == nil {
                    if let data = data {
                        do {
                            let jsonData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                            if let statusCode = jsonData?["statusCode"] as? Int, statusCode == 200 {
                                self.getUserDetails()
                            }else {
                                print("Show Error")
                            }
                        }catch  {
                            print(error.localizedDescription)
                        }
                    }
                }else {
                    print("Show Error")
                }
            }
        }
    }
    
    func getUserDetails() {
        let urlString = "https://n6lih99291.execute-api.ap-south-1.amazonaws.com/dev/user-details"
        
        var headers: [String: String] = [:]
        headers["Content-Type"] = "application/json"
        
        var urlParams: [String: String] = [:]
        urlParams["email"] = User.shared.savedUser?.email ?? ""
        
        NetworkAdaptor.request(url: urlString, method: .get, headers: headers, urlParameters: urlParams, bodyParameters: nil) { data, response, error in
            if error == nil {
                if let data = data {
                    do {
                        let userData = try JSONDecoder().decode(LoginModel.self, from: data)
                        if userData.statusCode == 200 {
                            let data = try JSONEncoder().encode(userData.data)
                            UserDefaults.standard.set(data, forKey: kuserDetails)
                            
                            if self.isFromLogin {
                                self.goToHome()
                            }else {
                                self.dismissScreen()
                            }
                        }else {
                            print("Show Error")
                        }
                    }catch {
                        print(error.localizedDescription)
                        print("Show Error")
                    }
                }
            }else {
                print("Show Error")
            }
        }
    }
    
    func dismissScreen() {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func goToHome() {
        DispatchQueue.main.async {
            let controller = Controllers.tabBar.getControllers()
            self.navigationController?.viewControllers = [controller]
        }
    }
    
    @IBAction func profileImageTapped(_ sender: UIButton) {
        if let controller = Controllers.profileImages.getControllers() as? ProfileImagesViewController {
            controller.delegate = self
            controller.modalPresentationStyle = .overFullScreen
            self.present(controller, animated: true, completion: nil)
        }
    }

    @IBAction func createProfileTapped(_ sender: UIButton) {
        createProfile()
    }
    
    @IBAction func closeTapped(_ sender: UIButton) {
        dismissScreen()
    }
}

extension ProfileViewController: ProfileImagesViewControllerDelegate {
    func selectedImage(image: String) {
        imageName = image
    }
}
