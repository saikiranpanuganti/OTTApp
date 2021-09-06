//
//  HomeModel.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 24/08/21.
//

import Foundation

// MARK: - Home
struct Home: Codable {
    let statusCode: Int?
    let body: HomeBody?
}

// MARK: - Body
struct HomeBody: Codable {
    let data: HomeData?
}

// MARK: - DataClass
struct HomeData: Codable {
    let id: Int?
    let title, type: String?
    let banner: [Video]?
    let playlists: [Playlist]?
}

// MARK: - Banner
struct Video: Codable {
    let id: Int?
    let videoID: String?
    let ageRating: String?
    let title: String?
    let contentType: ContentType?
    let imagery: Imagery?
    let friendly_url: String?

    enum CodingKeys: String, CodingKey {
        case id
        case videoID = "video_id"
        case ageRating = "age_rating"
        case title
        case contentType = "content_type"
        case imagery
        case friendly_url
    }
}

enum ContentType: String, Codable {
    case liveTV = "LiveTV"
    case movie = "movie"
    case series = "series"
}

// MARK: - Imagery
struct Imagery: Codable {
    let thumbnail, backdrop, mobileImg, banner: String?
    let featuredImg: String?

    enum CodingKeys: String, CodingKey {
        case thumbnail, backdrop
        case mobileImg = "mobile_img"
        case banner
        case featuredImg = "featured_img"
    }
}

// MARK: - Playlist
struct Playlist: Codable {
    let id: Int?
    let title: String?
    let content: [Video]?
}
