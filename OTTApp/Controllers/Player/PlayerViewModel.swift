//
//  PlayerViewModel.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 03/10/21.
//

import Foundation

protocol PlayerViewModelDelegate: AnyObject {
    func updateUI()
}

class PlayerViewModel {
    weak var delegate: PlayerViewModelDelegate?
    var videoUrl: String?
    var contentDetails: Details?
    
    func getVideoUrl() {
        var headers: [String: String] = [:]
        headers["Authorization"] = "cf606825b8a045c1aae39f7fe39de6c6"
        headers["Content-Type"] = "application/json"
        
        var bodyparameters: [String: Any] = [:]
        var urlParameters: [String: String] = [:]
        
        if contentDetails?.contentType?.rawValue == "series" {
            bodyparameters["episodenumber"] = 1
            urlParameters["type"] = "series"
            urlParameters["videoid"] = String(contentDetails?.id ?? 0)
        }else {
            urlParameters["type"] = "movie"
            urlParameters["videoid"] = String(contentDetails?.id ?? 0)
        }
        
        NetworkAdaptor.request(url: ApiHandler.videoUrl.url(), method: .post, headers: headers, urlParameters: urlParameters, bodyParameters: bodyparameters) { [weak self] data, response, error in
            
            guard let strongSelf = self else { return }
            
            if error == nil {
                if let data = data {
                    do {
                        let jsonData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                        if let videoUrl = jsonData?["video-url"] as? String{
                            print(videoUrl)
                            strongSelf.videoUrl = videoUrl
                            strongSelf.delegate?.updateUI()
                    }
                    }catch {
                        print(error.localizedDescription)
                    }
                }
            }else {
                print(error.debugDescription)
            }
        }
    }
    
    func saveProgress(progress: Int, duration: Int) {
        var headers: [String: String] = [:]
        headers["Content-Type"] = "application/json"
        
        var bodyparameters: [String: Any] = [:]
        bodyparameters["profileid"] = User.shared.selectedProfile?.profileID ?? ""
        bodyparameters["content_type"] = contentDetails?.contentType?.rawValue
        bodyparameters["contentid"] = contentDetails?.id
        bodyparameters["duration"] = duration
        bodyparameters["resume_position"] = progress
        
        NetworkAdaptor.request(url: ApiHandler.addToWatching.url(), method: .post, headers: headers, urlParameters: nil, bodyParameters: bodyparameters) { [weak self] data, response, error in
            if error == nil {
                if let data = data {
                    do {
                        if let jsonData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
                            if let status = jsonData["statusCode"] as? Int, status == 200 {
                                print("success saving to watching")
                            }
                        }
                    }catch {
                        print(error.localizedDescription)
                    }
                }
            }else {
                print(error.debugDescription)
            }
        }
    }
}
