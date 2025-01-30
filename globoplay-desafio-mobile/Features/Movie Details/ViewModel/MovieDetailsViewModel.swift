//
//  MovieDetailsViewModel.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 29/01/25.
//

import Combine
import UIKit

class MovieDetailsViewModel: ObservableObject {
    var cancellables = Set<AnyCancellable>()
    private let networkingManager = NetworkingManager()
    
    @Published var movieDetails: MovieDetails?
    @Published var movie: Movie
    @Published var relatedMovies: [Movie] = []
    @Published var isFavorite: Bool = false
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func fetchMovieDetails(movieId: Int) {
        isLoading = true
        networkingManager.getMovieDetails(movieId: movieId)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    print("Erro na fetchMovieDetails na ViewModel: \(error.localizedDescription)\n\n")
                }
            }, receiveValue: { [weak self] movieDetails in
                self?.movieDetails = movieDetails
                self?.isLoading = false
            })
            .store(in: &cancellables)
    }


    func toggleFavorite() {
        isFavorite.toggle()
    }
    
    func watchMovie() {
        // implementar a fuctionalidade para assistir o filme
    }
}
