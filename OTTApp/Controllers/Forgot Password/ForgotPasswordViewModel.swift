//
//  ForgotPasswordViewModel.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 24/09/21.
//

import Foundation

protocol ForgotPasswordViewModelDelegate:AnyObject {
    func forgotPassword(dobVerified:Bool,message:String)
}

class ForgotPasswordViewModel {
    
    weak var delegate:ForgotPasswordViewModelDelegate?
    
    func userForgotPassword(email:String,dob:String){
        var bodyParameters: [String: Any] = [:]
        bodyParameters["email"] = email
        bodyParameters["dob"] = dob
        
        var urlParameters: [String: String] = [:]
        urlParameters["type"] = "email"
        
        var headers: [String: String] = [:]
        headers["Content-Type"] = "application/json"
        
        
        NetworkAdaptor.request(url: ApiHandler.forgotPassword.url(), method: .post, headers: headers, urlParameters: urlParameters, bodyParameters: bodyParameters) { data, reponse, error in
            if let error = error {
                print(error.localizedDescription)
            }else{
                
                if let data = data{
                    
                    do{
                        
                        if  let jsonData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]{
                            
                            if let statusCode = jsonData["statusCode"] as? Int{
                                if statusCode != 200{
                                    self.delegate?.forgotPassword(dobVerified: false, message: "Date of dirth does not match")
                                }else{
                                    self.delegate?.forgotPassword(dobVerified: true, message: "Successfully verified date of birth")
                                }
                            }
                        }
                        
                    }catch{
                        print(error.localizedDescription)
                    }
                    
                    
                }
                
                
                
            }
        }
        
        
    }
}
