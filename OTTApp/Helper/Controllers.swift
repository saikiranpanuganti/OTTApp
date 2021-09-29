//
//  Controllers.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 24/08/21.
//

import UIKit
enum Controllers {
    case tabBar
    case home
    case users
    case categories
    case details
    case searchTab
    case register
    case login
    case forgotPassword
    case resetPassword
    case splash
    case settingsTab
    case webView
    
    func getControllers()->UIViewController {
        var storyBoardName = ""
        var storyBoardID = ""
        switch self {
        case .tabBar:
            storyBoardName = "Main"
            storyBoardID = "TabBarController"
        case .home :
            storyBoardName = "Main"
            storyBoardID = "HomeTabBarViewController"
        case .users:
            storyBoardName = "Main"
            storyBoardID = "UsersViewController"
        case .categories:
            storyBoardName = "Home"
            storyBoardID = "CategoriesViewController"
        case .details:
            storyBoardName = "Home"
            storyBoardID = "DetailsViewController"
        case .searchTab:
            storyBoardName = "Main"
            storyBoardID = "SearchViewController"
        case .register:
            storyBoardName = "OnBoarding"
            storyBoardID = "RegisterViewController"
        case .login:
            storyBoardName = "OnBoarding"
            storyBoardID = "LoginViewController"
        case .forgotPassword:
            storyBoardName = "OnBoarding"
            storyBoardID = "ForgotPasswordViewController"
        case .resetPassword:
            storyBoardName = "OnBoarding"
            storyBoardID = "ResetPasswordViewController"
        case .splash:
            storyBoardName = "Main"
            storyBoardID = "SplashViewController"
        case .settingsTab:
            storyBoardName = "Home"
            storyBoardID = "SettingsTabViewController"
        case .webView:
            storyBoardName = "Main"
            storyBoardID = "WebViewViewController"
        }
        
        return UIStoryboard(name: storyBoardName, bundle: nil).instantiateViewController(withIdentifier: storyBoardID)
    }
    
    
    
}
