//
//  SplashViewController.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 27/09/21.
//

import UIKit

class SplashViewController: UIViewController {

    var category: Category = .home
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkLoggedStatus()
    }
    
    func checkLoggedStatus() {
        if let isLoggedIn = UserDefaults.standard.value(forKey: kLoggedIn) as? Bool {
            if isLoggedIn {
                
                let controller = Controllers.users.getControllers()
                getData()
                getTvShowsData()
                getMoviesData()
                getMovieCategories()
                getTvShowsCategories()
                navigationController?.viewControllers = [controller]
                
            }else {
                let controller = Controllers.login.getControllers()
                navigationController?.viewControllers = [controller]
            }
        }else {
            let controller = Controllers.login.getControllers()
            navigationController?.viewControllers = [controller]
        }
    }

    
    
    func getData() {
        self.category = .home
        
//        if homeData != nil {
//            delegate?.updateUI()
//            return
//        }
        
        var headers : [String:String] = [:]
        headers["Authorization"] = "cf606825b8a045c1aae39f7fe39de6c6"
        
        NetworkAdaptor.request(url: ApiHandler.home.url(), method: .get,headers: headers) { data, response, error in
            do{
                if let error = error {
                    print(error.localizedDescription)
                }else{
                if let data = data {
                    let homeData = try JSONDecoder().decode(Home.self, from: data)
                  //  print(homeData)
                   // self.category = .home
                   // self.delegate?.updateUI()
                }
              }
            }
            catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func getTvShowsData() {
        self.category = .tvShows
        
//        if tvShowsData != nil {
//            delegate?.updateUI()
//            return
//        }
        
        var headers : [String:String] = [:]
        headers["Authorization"] = "cf606825b8a045c1aae39f7fe39de6c6"
        
        NetworkAdaptor.request(url: ApiHandler.tvshows.url(), method: .get,headers: headers) { data, response, error in
            do{
                if let error = error {
                    print(error.localizedDescription)
                }else{
                if let data = data {
                    let tvShowsData = try JSONDecoder().decode(Home.self, from: data)
                    //print(tvShowsData)
                   // self.delegate?.updateUI()
                }
                }
            }
                
            catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func getMoviesData() {
        self.category = .movies
//
//        if moviesData != nil {
//            delegate?.updateUI()
//            return
//        }
        
        var headers : [String:String] = [:]
        headers["Authorization"] = "cf606825b8a045c1aae39f7fe39de6c6"
        
        NetworkAdaptor.request(url: ApiHandler.movies.url(), method: .get,headers: headers) { data, response, error in
            do{
                if let error = error {
                    print(error.localizedDescription)
                }else{
                if let data = data {
                    let moviesData = try JSONDecoder().decode(Home.self, from: data)
                  //  print(moviesData)
                   // self.delegate?.updateUI()
                }
                }
            }
            catch{
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    func getMovieCategories() {
        let urlString = "https://yrc0uzwnw4.execute-api.ap-south-1.amazonaws.com/dev/moviecategories"
        
        var headers: [String: String] = [:]
        headers["Authorization"] = "cf606825b8a045c1aae39f7fe39de6c6"
        
        NetworkAdaptor.request(url: urlString, method: .get, headers: headers, urlParameters: nil, bodyParameters: nil) { data, response, error in
            if error == nil {
                if let data = data {
                    do {
                        let moviesCategoriesData = try JSONDecoder().decode(CategoryModel.self, from: data)
                        print(moviesCategoriesData)
                        //self.delegate?.updateUI()
                    }catch  {
                        print(error.localizedDescription)
                    }
                }
            }else {
                print("Show Alert")
            }
        }
    }
    
    func getTvShowsCategories() {
        let urlString = "https://yrc0uzwnw4.execute-api.ap-south-1.amazonaws.com/dev/tvcategories"
        
        var headers: [String: String] = [:]
        headers["Authorization"] = "cf606825b8a045c1aae39f7fe39de6c6"
        
        NetworkAdaptor.request(url: urlString, method: .get, headers: headers, urlParameters: nil, bodyParameters: nil) { data, response, error in
            if error == nil {
                if let data = data {
                    do {
                       let tvCategoriesData = try JSONDecoder().decode(CategoryModel.self, from: data)
                        print(tvCategoriesData)
                      //  self.delegate?.updateUI()
                    }catch  {
                        print(error.localizedDescription)
                    }
                }
            }else {
                print("Show Alert")
            }
        }
    }
    
    
    
}
