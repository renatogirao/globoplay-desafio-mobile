//
//  FavoritesViewRepresentable.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 31/01/25.
//

import SwiftUI

struct FavoritesViewRepresentable: UIViewRepresentable {
    var movies: [Movie] 

    func makeUIView(context: Context) -> FavoritesView {
        let favoritesView = FavoritesView()
        return favoritesView
    }

    func updateUIView(_ uiView: FavoritesView, context: Context) {
        uiView.updateMovies(movies)
    }
}
