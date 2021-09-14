//
//  DetailsViewModel.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 14/09/21.
//

import Foundation

protocol DetailsViewModelDelegate: AnyObject {
    func updateUI()
}

class DetailsViewModel {
    weak var delegate: DetailsViewModelDelegate?
    var video: Video?
    var details: Details?
    
    func getData() {
        if let videoId = video?.id, let contentType = video?.contentType {
            var urlString = ""
            var parameters: [String: String] = [:]
            
            if contentType == .movie {
                urlString = ApiHandler.movieDetails.url()
                parameters["movieid"] = String(videoId)
            }else if contentType == .series {
                urlString = ApiHandler.seriesDetails.url()
                parameters["seriesid"] = String(videoId)
            }
            
            getDetails(urlString: urlString, parameters: parameters, contentType: contentType)
        }
    }
    
    func getDetails(urlString: String, parameters: [String: String], contentType: ContentType) {
        
        NetworkAdaptor.request(url: urlString, method: .get, headers: nil, urlParameters: parameters, bodyParameters: nil) { data, response, error in
            if error == nil {
                do {
                    if let data = data {
                        if contentType == .movie {
                            let detailsData = try JSONDecoder().decode(MovieDetailsModel.self, from: data)
                            self.details = detailsData.data
                        }else if contentType == .series {
                            let detailsData = try JSONDecoder().decode(SeriesDetailsModel.self, from: data)
                            self.details = detailsData.data?.response
                        }
                        self.delegate?.updateUI()
                    }
                }catch {
                    print(error.localizedDescription)
                }
            }else {
                print(error.debugDescription)
            }
        }
    }
}
