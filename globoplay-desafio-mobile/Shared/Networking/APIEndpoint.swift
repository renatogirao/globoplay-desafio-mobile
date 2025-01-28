//
//  APIEndpoints.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 28/01/25.
//

import Foundation

enum APIEndpoint: String {
    case home = "/movie/popular"
    case movieDetail = "/movie/"
    case search = "/search/movie"
    
    var urlString: String {
        return "https://api.themoviedb.org/3\(self.rawValue)"
    }
}
