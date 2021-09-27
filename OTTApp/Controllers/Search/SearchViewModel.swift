//
//  SearchViewModel.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 21/09/21.
//

import Foundation

protocol SearchViewModelDelegate: AnyObject {
    func updateUI()
}

class SearchViewModel {
    weak var delegate: SearchViewModelDelegate?
    var searchdata: SearchModel?
    
    func getSearchData(queryString: String) {
        var parameters: [String: String] = [:]
        parameters["search_query"] = queryString
        
        NetworkAdaptor.request(url: ApiHandler.search.url(), method: .get, headers: nil, urlParameters: parameters, bodyParameters: nil) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            }else {
                if let data = data {
                    do {
                        self.searchdata = try JSONDecoder().decode(SearchModel.self, from: data)
                        self.delegate?.updateUI()
                    }catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}



struct SearchModel: Codable {
    let status: Int?
    let response: [Video]?
}
