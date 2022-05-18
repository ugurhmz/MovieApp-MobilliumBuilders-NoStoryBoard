//
//  MovieUpComingModel.swift
//  MovieCase
//
//  Created by ugur-pc on 18.05.2022.
//

// MARK: - Welcome
public struct MovieUpComingModel: Codable {
    let dates: MyDates?
    let page: Int?
    let results: [MovieUpComingInfo]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages
        case totalResults
    }
}

// MARK: - Dates
struct MyDates: Codable {
    let maximum, minimum: String?
}

// MARK: - Result
struct MovieUpComingInfo: Codable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let originalLanguage: String?
    let originalTitle, overview: String?
    let popularity: Double?
    let posterPath, releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS   = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle  = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate    = "release_date"
        case title, video
        case voteAverage    = "vote_average"
        case voteCount      = "vote_count"
    }
}
