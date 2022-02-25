//
//  User.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 24/02/22.
//

import Foundation

class User {
    static let shared: User = User()
    
    var savedUser: UserData? {
        if let data = UserDefaults.standard.value(forKey: kuserDetails) as? Data {
            return try? JSONDecoder().decode(UserData.self, from: data)
        }
        return nil
    }
    
    var selectedProfile: Profile?
}
