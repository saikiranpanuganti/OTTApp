//
//  HomeTabViewModel.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 24/08/21.
//

protocol HomeTabViewModelDeleagte:AnyObject {
    func updateUI()
}

import Foundation

class HomeTabViewModel{
    
    weak var delegate:HomeTabViewModelDeleagte?
    var homeData:Home?
    var tvShowsData:Home?
    var moviesData:Home?
    var category: Category = .home
    var subCategoryData: SubCategory?
    var subCategoryDataDicTvShows: [String: SubCategory] = [:]
    var subCategoryDataDicMovies: [String: SubCategory] = [:]
    
    func getData() {
        self.category = .home
        homeData = AppData.shared.homeData
        delegate?.updateUI()
        
//        if homeData != nil {
//            delegate?.updateUI()
//            return
//        }
//
//        var headers : [String:String] = [:]
//        headers["Authorization"] = "cf606825b8a045c1aae39f7fe39de6c6"
//
//        NetworkAdaptor.request(url: ApiHandler.home.url(), method: .get,headers: headers) { data, response, error in
//            do{
//                if let data = data {
//                    self.homeData = try JSONDecoder().decode(Home.self, from: data)
//                    self.category = .home
//                    self.delegate?.updateUI()
//                }
//            }
//            catch{
//                print(error.localizedDescription)
//            }
//        }
        
    }
    
    func getTvShowsData() {
        self.category = .tvShows
        
        if tvShowsData != nil {
            delegate?.updateUI()
            return
        }
        
        var headers : [String:String] = [:]
        headers["Authorization"] = "cf606825b8a045c1aae39f7fe39de6c6"
        
        NetworkAdaptor.request(url: ApiHandler.tvshows.url(), method: .get,headers: headers) { data, response, error in
            do{
                if let data = data {
                    self.tvShowsData = try JSONDecoder().decode(Home.self, from: data)
                    self.delegate?.updateUI()
                }
            }
            catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func getMoviesData() {
        self.category = .movies
        
        if moviesData != nil {
            delegate?.updateUI()
            return
        }
        
        var headers : [String:String] = [:]
        headers["Authorization"] = "cf606825b8a045c1aae39f7fe39de6c6"
        
        NetworkAdaptor.request(url: ApiHandler.movies.url(), method: .get,headers: headers) { data, response, error in
            do{
                if let data = data {
                    self.moviesData = try JSONDecoder().decode(Home.self, from: data)
                    self.delegate?.updateUI()
                }
            }
            catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func getSubCategoryData(subCategory: String, urlString: String, isMovies: Bool) {
        var headers : [String:String] = [:]
        headers["Authorization"] = "cf606825b8a045c1aae39f7fe39de6c6"
        
        var parameters: [String: String] = [:]
        parameters["category"] = subCategory.replacingOccurrences(of: " ", with: "")
        
        NetworkAdaptor.request(url: urlString, method: .get, headers: headers, urlParameters: parameters) { data, response, error in
            do{
                if let data = data {
                    self.subCategoryData = try JSONDecoder().decode(SubCategory.self, from: data)
                    if isMovies {
                        self.subCategoryDataDicMovies[subCategory] = self.subCategoryData
                    }else {
                        self.subCategoryDataDicTvShows[subCategory] = self.subCategoryData
                    }
                    
                    self.delegate?.updateUI()
                }
            }
            catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func movieSubCategoryTapped(subCategory: String) {
        self.category = .subCategory
        
        if let data = subCategoryDataDicMovies[subCategory] {
            subCategoryData = data
            delegate?.updateUI()
            return
        }
        
        getSubCategoryData(subCategory: subCategory, urlString: ApiHandler.movieSubCategory.url(), isMovies: true)
    }
    
    func tvShowsSubCategoryTapped(subCategory: String) {
        self.category = .subCategory
        
        if let data = subCategoryDataDicTvShows[subCategory] {
            subCategoryData = data
            delegate?.updateUI()
            return
        }

        getSubCategoryData(subCategory: subCategory, urlString: ApiHandler.tvShowsCategory.url(), isMovies: false)
    }
}
