//
//  ResetPasswordViewModel.swift
//  OTTApp
//
//  Created by pampana ajay on 26/09/21.
//

import Foundation

protocol ResetPasswordViewModelDelegate:AnyObject {
    func resetPassword(success:Bool,message:String)
}


class ResetPasswordViewModel {
    
    weak var delegate:ResetPasswordViewModelDelegate?
    func userResetPassword(email:String,password:String){
        
        var bodyParameters: [String: Any] = [:]
        bodyParameters["email"] = email
        bodyParameters["password"] = password
        
        var urlParameters: [String: String] = [:]
        urlParameters["type"] = "email"
        
        var headers: [String: String] = [:]
        headers["Content-Type"] = "application/json"
        
        
        NetworkAdaptor.request(url: ApiHandler.resetPassword.url(), method: .put, headers: headers, urlParameters: urlParameters, bodyParameters: bodyParameters) { data, response, error in
            
            if let error = error{
                print(error.localizedDescription)
            }else{
                
                do{
                    if let data = data{
                    if let jsonData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any] {
                        if let stausCode = jsonData["statusCode"] as? Int{
                            
                            if stausCode != 200{
                                self.delegate?.resetPassword(success: false, message: "Server Error")
                            }else{
                                self.delegate?.resetPassword(success: true, message: "Password Reset Successful")
                            }
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
