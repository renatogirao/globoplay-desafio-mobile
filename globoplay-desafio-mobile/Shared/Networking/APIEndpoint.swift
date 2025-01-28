//
//  APIEndpoints.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 28/01/25.
//

import Foundation

enum APIEndpoint: String {
    case movieDetail = "/movie/"
    case search = "/search/movie"
    case nowPlaying = "/movie/now_playing"
    case popular = "/movie/popular"
    case topRated = "/movie/top_rated"
    case upcoming = "/movie/upcoming"
    case genres = "/genre/movie/list"
    case trendingPeople = "/trending/person/week"
        
        var urlString: String {
            return "https://api.themoviedb.org/3\(self.rawValue)"
        }
}
