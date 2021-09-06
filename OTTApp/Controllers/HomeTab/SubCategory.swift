//
//  SubCategory.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 06/09/21.
//

import Foundation


struct SubCategory: Codable {
    let statusCode: Int?
    let body: SubCategoryBody?
}

// MARK: - Body
struct SubCategoryBody: Codable {
    let data: SubCategoryData?
}

// MARK: - DataClass
struct SubCategoryData: Codable {
    let title, type: String?
    let banner: Video?
    let playlists: [Video]?
}
