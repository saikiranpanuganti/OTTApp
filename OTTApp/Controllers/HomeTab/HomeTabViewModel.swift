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
    
    func getData(){
        
        var headers : [String:String] = [:]
        headers["Authorization"] = "cf606825b8a045c1aae39f7fe39de6c6"
        
        NetworkAdaptor.request(url: "https://yrc0uzwnw4.execute-api.ap-south-1.amazonaws.com/dev/home", method: .get,headers: headers) { data, response, error in
            do{
                if let data = data {
                    self.homeData = try JSONDecoder().decode(Home.self, from: data)
                    self.delegate?.updateUI()
                }
                
                
            }
            catch{
                print(error.localizedDescription)
            }
            
            
        }
        
    }
    
}
