//
//  RegisterViewModel.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 22/09/21.
//

import Foundation

protocol RegisterViewModelDelegate: AnyObject {
    func registrationResponse(success: Bool, message: String?)
}


class RegisterViewModel {
    weak var delegate: RegisterViewModelDelegate?
    
    func registerUser(email: String, password: String, dob: String) {
        var bodyParameters: [String: Any] = [:]
        bodyParameters["email"] = email
        bodyParameters["password"] = password
        bodyParameters["dob"] = dob
        
        var urlParameters: [String: String] = [:]
        urlParameters["type"] = "email"
        
        var headers: [String: String] = [:]
        headers["Content-Type"] = "application/json"
        
        NetworkAdaptor.request(url: ApiHandler.register.url(), method: .post, headers: headers, urlParameters: urlParameters, bodyParameters: bodyParameters) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            }else {
                if let data = data {
                    do {
                        if let jsonData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
                            if let status = jsonData["statusCode"] as? Int {
                                if status != 200 {
                                    let message = jsonData["data"] as? String
                                    self.delegate?.registrationResponse(success: false, message: message ?? "Server Error")
                                }else {
                                    self.delegate?.registrationResponse(success: true, message: nil)
                                }
                            }
                        }
                    }catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}
