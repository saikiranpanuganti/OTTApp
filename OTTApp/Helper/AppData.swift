//
//  AppData.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 28/09/21.
//

import Foundation

class AppData {
    static let shared: AppData = AppData()
    
    private init() { }
    
    var homeData: Home?
    var moviesCategoriesData: CategoryModel?
    var tvCategoriesData: CategoryModel?
}
