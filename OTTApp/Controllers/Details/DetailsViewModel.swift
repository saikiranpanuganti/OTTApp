//
//  DetailsViewModel.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 14/09/21.
//

import Foundation

protocol DetailsViewModelDelegate: AnyObject {
    func showLoader()
    func hideLoader()
    func updateUI()
}

class DetailsViewModel {
    weak var delegate: DetailsViewModelDelegate?
    var video: Video?
    var details: Details?
    var moreLikeThisData: MoreLikeThisModel?
    
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
            getMoreLikeThisData()
        }
    }
    
    func getDetails(urlString: String, parameters: [String: String], contentType: ContentType) {
        delegate?.showLoader()
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
            self.delegate?.hideLoader()
        }
    }
    
    func getMoreLikeThisData() {
        if let contentType = video?.contentType {
            delegate?.showLoader()
            
            var headers: [String: String] = [:]
            headers["Authorization"] = "cf606825b8a045c1aae39f7fe39de6c6"
            
            var parameters: [String: String] = [:]
            parameters["contenttype"] = contentType.rawValue
            parameters["timestamp"] = String(Int(Date().timeIntervalSince1970))
            
            NetworkAdaptor.request(url: ApiHandler.relatedContent.url(), method: .get, headers: headers, urlParameters: parameters) { data, response, error in
                if error == nil {
                    do {
                        if let data = data {
                            self.moreLikeThisData = try JSONDecoder().decode(MoreLikeThisModel.self, from: data)
                        }
                    }catch {
                        print(error.localizedDescription)
                    }
                }else {
                    print(error.debugDescription)
                }
                self.delegate?.hideLoader()
            }
        }
    }
    
    func addToList() {
        self.delegate?.showLoader()
        var headers: [String: String] = [:]
        headers["Content-Type"] = "application/json"
        
        var bodyParams: [String: Any] = [:]
        bodyParams["content_type"] = details?.contentType?.rawValue
        bodyParams["contentid"] = details?.id
        bodyParams["profileid"] = User.shared.selectedProfile?.profileID ?? ""
        
        NetworkAdaptor.request(url: ApiHandler.addToWatching.url(), method: .post, headers: headers, urlParameters: nil, bodyParameters: bodyParams) { data, response, error in
            if error == nil {
                do {
                    if let data = data {
                        if let jsonData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
                            if let status = jsonData["statusCode"] as? Int, status == 200 {
                                print("Success adding to Mylist")
                                print("Get mylist data")
                            }
                        }
                    }
                }catch {
                    print(error.localizedDescription)
                }
            }else {
                print(error.debugDescription)
            }
            self.delegate?.hideLoader()
        }
    }
}
