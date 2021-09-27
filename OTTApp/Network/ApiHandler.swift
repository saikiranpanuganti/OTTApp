//
//  ApiHandler.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 02/09/21.
//

import Foundation

enum ApiHandler {
    case home
    case tvshows
    case movies
    case movieSubCategory
    case tvShowsCategory
    case movieDetails
    case seriesDetails
    case relatedContent
    case search
    case register
    case login
    case forgotPassword
    case resetPassword
    
    func url() -> String {
        let baseUrl = "https://yrc0uzwnw4.execute-api.ap-south-1.amazonaws.com/dev/"
        let baseUrl1 = "https://n6lih99291.execute-api.ap-south-1.amazonaws.com/dev/"
       
        switch self {
        case .home:
            return baseUrl + "home"
        case .tvshows:
            return baseUrl + "tvshows"
        case .movies:
            return baseUrl + "movies"
        case .movieSubCategory:
            return baseUrl + "moviecontent"
        case .tvShowsCategory:
            return baseUrl + "tvcontent"
        case .movieDetails:
            return baseUrl1 + "moviedetails"
        case .seriesDetails:
            return baseUrl1 + "seriesdetails"
        case .relatedContent:
            return baseUrl + "relatedcontent"
        case .search:
            return baseUrl1 + "search"
        case .register:
            return baseUrl1 + "register"
        case .login:
            return baseUrl1 + "login"
        case .forgotPassword:
            return baseUrl1 + "forgot-password"
        case .resetPassword:
            return baseUrl1 + "reset-password"
        }
    }
}

