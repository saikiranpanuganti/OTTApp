//
//  ConfigData.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 21/10/21.
//

import Foundation


// MARK: - ConfigData
struct ConfigData: Codable {
    let statusCode: Int
    let data: [String: Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let cms, geolocation: String
    let login: Login
    let appUpdate: AppUpdate

    enum CodingKeys: String, CodingKey {
        case cms = "CMS"
        case geolocation = "Geolocation"
        case login = "Login"
        case appUpdate = "AppUpdate"
    }
}

// MARK: - AppUpdate
struct AppUpdate: Codable {
    let appVersion, currentAppstoreVersion: String
    let hidecode: Int
    let updateMessage: String

    enum CodingKeys: String, CodingKey {
        case appVersion = "app_version"
        case currentAppstoreVersion = "current_appstore_version"
        case hidecode
        case updateMessage = "update_message"
    }
}

// MARK: - Login
struct Login: Codable {
    let facebook, twitter, email: Int

    enum CodingKeys: String, CodingKey {
        case facebook = "Facebook"
        case twitter, email
    }
}
