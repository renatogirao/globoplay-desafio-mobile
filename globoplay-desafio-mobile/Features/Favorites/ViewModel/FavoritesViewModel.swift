//
//  FavoritesViewModel.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 31/01/25.
//

import Foundation
import CoreData

class FavoritesViewModel {
    
    private let movieRepository = MovieCoreDataRepository()
    var favoriteMovies: [Movie] = []
    
    func fetchFavoriteMovies(completion: @escaping () -> Void) {
        movieRepository.fetchFavorites { [weak self] movies in
            self?.favoriteMovies = movies
            completion()
        }
    }
}
