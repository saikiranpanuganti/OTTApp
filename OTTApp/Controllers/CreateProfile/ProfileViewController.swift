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

    
    var imageName: String = "profile1" {
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
            titleLabel.text = "Please create a profile to continue"
            viewCenterY.constant = 0
        }
        
        nameTextfield.attributedPlaceholder = NSAttributedString(string: "Enter profile name", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
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
                                self.goToHome()
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
}

extension ProfileViewController: ProfileImagesViewControllerDelegate {
    func selectedImage(image: String) {
        imageName = image
    }
}
