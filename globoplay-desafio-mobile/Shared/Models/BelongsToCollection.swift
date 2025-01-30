//
//  BelongsToCollection.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 29/01/25.
//

import Foundation

struct BelongsToCollection: Codable {
    let id: Int
    let name: String
    let posterPath: String?
    let backdropPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}
