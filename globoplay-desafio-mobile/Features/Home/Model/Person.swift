//
//  Person.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 28/01/25.
//

import Foundation

struct Person: Identifiable, Codable {
    let id: Int
    let name: String
    let profilePath: String?
}
