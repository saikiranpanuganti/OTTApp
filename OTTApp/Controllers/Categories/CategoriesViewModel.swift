//
//  CategoriesViewModel.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 01/09/21.
//

import Foundation

enum Category {
    case movies
    case tvShows
    case home
    case subCategory
}

protocol CategoriesViewModelDelegate: AnyObject {
    func updateUI()
}

class CategoriesViewModel {
    weak var delegate: CategoriesViewModelDelegate?
    
    var category: Category = .movies
    var categoriesData: CategoryModel?
    var homeCategoriesData: [String] = ["Home", "TV Shows", "Movies", "My List"]
    
    func getData() {
        if category == .movies {
            getMovieCategories()
        }else if category == .tvShows {
            getTvShowsCategories()
        }else if category == .home {
            delegate?.updateUI()
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
                        self.categoriesData = try JSONDecoder().decode(CategoryModel.self, from: data)
                        self.delegate?.updateUI()
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
                        self.categoriesData = try JSONDecoder().decode(CategoryModel.self, from: data)
                        self.delegate?.updateUI()
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
