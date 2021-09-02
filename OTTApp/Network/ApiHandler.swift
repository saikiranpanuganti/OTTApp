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
    
    func url() -> String {
        let baseUrl = "https://yrc0uzwnw4.execute-api.ap-south-1.amazonaws.com/dev/"
        
        switch self {
        case .home:
            return baseUrl + "home"
        case .tvshows:
            return baseUrl + "tvshows"
        case .movies:
            return baseUrl + "movies"
        }
    }
}

