//
//  LoginViewModel.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 24/09/21.
//

import Foundation

protocol LoginViewModelDelegate:AnyObject{
    func loginResponse(success: Bool, message: String?)
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
                       if let jsonData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]
                       {
                        if let status = jsonData["statusCode"] as? Int{
                            if status != 200{
                                
                                self.delegate?.loginResponse(success: false, message: "Server Error")
                                
                            }else{
                                
                                self.delegate?.loginResponse(success: true, message: "Login Successful")
                            }
                            print(status)
                        }
                       }

                    }
                    catch{
                        
                        print(error.localizedDescription)
                    }
                    
                    
                    
                }
                
                
                
                
                
                
            }
        }
        
    }
    
}
