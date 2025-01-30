//
//  SpokenLanguage.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 29/01/25.
//

import Foundation

struct SpokenLanguage: Codable {
    let englishName: String
    let iso6391: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso6391 = "iso_639_1"
        case name
    }
}
