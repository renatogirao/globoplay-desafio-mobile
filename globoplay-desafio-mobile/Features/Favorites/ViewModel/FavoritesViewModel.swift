//
//  FavoritesViewModel.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 31/01/25.
//

import Foundation
import CoreData
import Combine

class FavoritesViewModel: ObservableObject {
    
    @Published var favoriteMovies: [Movie] = []
    
    var onMoviesLoaded: (() -> Void)?
    var onError: ((Error) -> Void)?
    
    private let movieRepository = MovieCoreDataRepository()
    
    func fetchFavoriteMovies() {
        movieRepository.getFavorites { [weak self] result in
            switch result {
            case .success(let movies):
                self?.favoriteMovies = movies
                self?.onMoviesLoaded?()
            case .failure(let error):
                self?.onError?(error)
            }
        }
    }
    
    func numberOfItemsInSection() -> Int {
        return favoriteMovies.count
    }
    
    func movieForItem(at indexPath: IndexPath) -> Movie {
        return favoriteMovies[indexPath.row]
    }
}
