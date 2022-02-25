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
    let data: UserData?
}

// MARK: - UserData
struct UserData: Codable {
    let password, email, userid, dob: String?
    let profiles: [Profile]?
}

// MARK: - Profile
struct Profile: Codable {
    let profileName, profileID, profileImage: String?

    enum CodingKeys: String, CodingKey {
        case profileName
        case profileID = "profileId"
        case profileImage
    }
}
