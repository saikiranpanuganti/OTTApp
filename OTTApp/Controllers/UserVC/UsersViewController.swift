//
//  UsersViewController.swift
//  OTTApp
//
//  Created by pampana ajay on 27/08/21.
//

import UIKit

class UsersViewController: UIViewController {
    
    @IBOutlet weak var usersView:UsersView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        usersView.delegate = self
        usersView.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        usersView.updateUI()
    }
    
    func deleteUserProfile(profile: Profile) {
        let urlString = "https://n6lih99291.execute-api.ap-south-1.amazonaws.com/dev/update-user"
        
        var headers: [String: String] = [:]
        headers["Content-Type"] = "application/json"
        
        var bodyParams: [String: Any] = [:]
        bodyParams["email"] = User.shared.savedUser?.email ?? ""
        bodyParams["profile"] = ["profileId": profile.profileID]
        
        NetworkAdaptor.request(url: urlString, method: .delete, headers: headers, urlParameters: nil, bodyParameters: bodyParams) { data, response, error in
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
                            
                            self.usersView.updateUI()
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
}

extension UsersViewController: UsersViewDelegate {
    func profileTapped() {
        let controller = Controllers.tabBar.getControllers()
        navigationController?.viewControllers = [controller]
    }
    
    func addProfile() {
        DispatchQueue.main.async {
            if let controller = Controllers.createProfile.getControllers() as? ProfileViewController {
                controller.createProfileTitle = ""
                controller.isFromLogin = false
                self.navigationController?.pushViewController(controller, animated: true)
            }
        }
    }
    
    func deleteProfile(profile: Profile) {
        deleteUserProfile(profile: profile)
    }
}
