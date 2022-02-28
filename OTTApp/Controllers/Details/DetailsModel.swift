//
//  DetailsModel.swift
//  OTTApp
//
//  Created by SaiKiran Panuganti on 14/09/21.
//

import Foundation


// MARK: - DetailsModel
struct SeriesDetailsModel: Codable {
    let data: SeriesData?
}

// MARK: - DataClass
struct SeriesData: Codable {
    let statusCode: Int?
    let response: Details?
}

// MARK: - Details
struct Details: Codable {
    let id: Int?
    let ageRating, videoID, friendlyURL: String?
    let contentType: ContentType?
    let synopsis: String?
    let length: Int?
    let title: String?
    let cast: [String]?
    let seoDescription, translatedTitle: String?
    let genres: [String]?
    let seoTitle: String?
    let imagery: Imagery?
    let seasons: [Season]?
    let insertedAt, modifiedAt: String?
    let geoblock: Int?
    let movies: [Movie]?

    enum CodingKeys: String, CodingKey {
        case id
        case ageRating = "age_rating"
        case videoID = "video_id"
        case friendlyURL = "friendly_url"
        case contentType = "content_type"
        case synopsis
        case length, title, cast
        case seoDescription = "seo_description"
        case translatedTitle = "translated_title"
        case genres
        case seoTitle = "seo_title"
        case imagery, seasons, insertedAt, modifiedAt, geoblock, movies
    }
}


// MARK: - Season
struct Season: Codable {
    let id, seasonNumber, dubbed: Int?
    let seoDescription: String?
    let seoTitle, title: String?
    let imagery: Imagery?
    let episodes: [Episode]?
    let geoblock, digitalRighttype: Int?
    let digitalRightsRegions: String?

    enum CodingKeys: String, CodingKey {
        case id
        case seasonNumber = "season_number"
        case dubbed
        case seoDescription = "seo_description"
        case seoTitle = "seo_title"
        case title, imagery, episodes, geoblock, digitalRighttype, digitalRightsRegions
    }
}

// MARK: - Episode
struct Episode: Codable {
    let id, seriesID, episodeNumber: Int?
    let videoID, synopsis: String?
    let length: Int?
    let title: String?
    let imagery: Imagery?
    let insertedAt: String?
    let geoblock, digitalRighttype: Int?
    let digitalRightsRegions: String?

    enum CodingKeys: String, CodingKey {
        case id
        case seriesID = "series_id"
        case episodeNumber = "episode_number"
        case videoID = "video_id"
        case synopsis, length, title, imagery, insertedAt, geoblock, digitalRighttype, digitalRightsRegions
    }
}




// MARK: - DetailsModel
struct MovieDetailsModel: Codable {
    let statusCode: Int?
    let data: Details?
}

// MARK: - Movie
struct Movie: Codable {
    let id: Int?
    let title: String?
    let insertedAt: String?
    let geoblock, digitalRighttype: Int?
}




struct MoreLikeThisModel: Codable {
    let status: Int?
    let response: [Video]?
}
