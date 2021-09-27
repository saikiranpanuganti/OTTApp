//
//  LoginModel.swift
//  OTTApp
//
//  Created by pampana ajay on 25/09/21.
//



import Foundation

// MARK: - LoginModel
struct LoginModel: Codable {
    let statusCode: Int?
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let password, email, userid, dob: String?
}
