//
//  Movie.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 28/01/25.
//

struct Movie: Codable {
    
    let id: Int
    let title: String
    let posterPath: String?
    let overview: String?
    let backdropPath: String?
    let genreIds: [Int]?
    let voteCount: Int?
    let adult: Bool?
    let releaseDate: String
    let originalLanguage: String?
    let originalTitle: String?
    let popularity: Double?
    let video: Bool?
    let voteAverage: Double?

    enum CodingKeys: String, CodingKey {
        case id, title, overview, backdropPath, genreIds
        case posterPath = "poster_path"
        case voteCount = "vote_count"
        case adult
        case releaseDate = "release_date"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case popularity
        case video
        case voteAverage = "vote_average"
    }
}


