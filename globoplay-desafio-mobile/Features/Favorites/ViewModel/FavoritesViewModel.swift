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
    
    // MARK: - Properties
    private let movieRepository = MovieCoreDataRepository()
    @Published var favoriteMovies: [Movie] = []
    
    // MARK: - Closures for Binding
    var onMoviesLoaded: (() -> Void)?
    var onError: ((Error) -> Void)?
    
    // MARK: - Fetch Data
    func fetchFavoriteMovies() {
        print("Fetching favorite movies...")
        movieRepository.getFavorites { [weak self] result in
            switch result {
            case .success(let movies):
                print("Movies loaded: \(movies.count)")
                self?.favoriteMovies = movies
                self?.onMoviesLoaded?()
            case .failure(let error):
                self?.onError?(error)
                print("Error loading movies: \(error)")
            }
        }
    }


    // MARK: - Helper Methods for View
    func numberOfItemsInSection() -> Int {
        return favoriteMovies.count
    }
    
    func movieForItem(at indexPath: IndexPath) -> Movie {
        return favoriteMovies[indexPath.row]
    }
}
