//
//  ProductionCompany.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 29/01/25.
//

import Foundation

struct ProductionCompany: Codable {
    let id: Int
    let logoPath: String?
    let name: String
    let originCountry: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case logoPath
        case name
        case originCountry = "origin_country"
    }
}

struct ProductionCountry: Codable {
    let iso31661: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case iso31661 = "iso_3166_1"
        case name
    }
}

