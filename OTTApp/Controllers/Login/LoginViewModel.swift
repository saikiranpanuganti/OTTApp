//
//  LoginViewModel.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 24/09/21.
//

import Foundation

protocol LoginViewModelDelegate:AnyObject{
    func loginResponse(success: Bool, message: String?)
    func navigateToCreateProfilesVC()
}

class LoginViewModel {
    
    weak var delegate:LoginViewModelDelegate?
    
    
    func loginUser(email:String,password:String){
        var bodyParameters: [String: Any] = [:]
        bodyParameters["email"] = email
        bodyParameters["password"] = password
        
        var urlParameters: [String: String] = [:]
        urlParameters["type"] = "email"
        
        var headers: [String: String] = [:]
        headers["Content-Type"] = "application/json"
        
        NetworkAdaptor.request(url: ApiHandler.login.url(), method: .post, headers: headers, urlParameters: urlParameters, bodyParameters: bodyParameters) { data, response, error in
            if let error = error{
                print(error.localizedDescription)
            }else{
                if let data = data {
                    do{
                        let loginData = try JSONDecoder().decode(LoginModel.self, from: data)
                        if loginData.statusCode == 200 {
                            UserDefaults.standard.setValue(true, forKey: kLoggedIn)
                            
                            let data = try JSONEncoder().encode(loginData.data)
                            UserDefaults.standard.set(data, forKey: kuserDetails)
                            
                            self.handleLoginSuccess(user: loginData)
                        }else {
                            self.delegate?.loginResponse(success: false, message: "Server Error")
                        }
                    }catch {
                        print(error.localizedDescription)
                        let errorData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
                        self.delegate?.loginResponse(success: false, message: "Server Error")
                    }
                }
            }
        }
    }
    
    func handleLoginSuccess(user: LoginModel) {
        if let profiles = user.data?.profiles, profiles.count > 0 {
            self.delegate?.loginResponse(success: true, message: "User successfully logged in")
        }else {
            delegate?.navigateToCreateProfilesVC()
        }
    }
    
}


