//
//  MovieVideo.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 01/02/25.
//

import Foundation

struct MovieVideo: Codable, Identifiable {
    let id: String
    let key: String
    let site: String
    let type: String
}

struct MovieVideosResponse: Codable {
    let results: [MovieVideo]
}
