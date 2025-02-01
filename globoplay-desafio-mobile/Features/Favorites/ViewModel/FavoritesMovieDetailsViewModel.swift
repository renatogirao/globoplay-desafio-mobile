//
//  FavoritesMovieDetailsViewModel.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 31/01/25.
//

import Foundation
import Combine

class FavoritesMovieDetailsViewModel {
    
    // MARK: - Properties
    private let movie: Movie
    var cancellables = Set<AnyCancellable>()
    private var details: MovieDetails?
    
    var movieDetailsPublisher = PassthroughSubject<MovieDetails?, Error>()
    var loadingPublisher = PassthroughSubject<Bool, Never>()
    
    // MARK: - Initializer
    init(movie: Movie) {
        self.movie = movie
    }
    
    // MARK: - Fetch Movie Details
    func fetchMovieDetails() {
        loadingPublisher.send(true)
        
        NetworkingManager.shared.getMovieDetails(movieId: movie.id)
            .sink { [weak self] completion in
                self?.loadingPublisher.send(false)
                
                if case .failure(let error) = completion {
                    print("Erro ao obter detalhes do filme: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] details in
                self?.details = details
                self?.movieDetailsPublisher.send(details)
            }
            .store(in: &cancellables)
    }
}
