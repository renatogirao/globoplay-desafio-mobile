//
//  MovieSection.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 28/01/25.
//

import Foundation

struct MovieSection: Identifiable {
    let id = UUID()
    let title: String
    let movies: [Movie]
}
