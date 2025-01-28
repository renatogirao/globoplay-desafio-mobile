//
//  MovieDetails.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 28/01/25.
//

import Foundation

struct MovieDetail: Identifiable, Codable {
    let id: Int
    let title: String
    let overview: String
    let releaseDate: String
    let posterPath: String
    let backdropPath: String
    let genres: [Genre]
    let runtime: Int
    let voteAverage: Double
    let voteCount: Int
}
