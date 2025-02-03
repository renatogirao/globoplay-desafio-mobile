//
//  Untitled.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 01/02/25.
//

import Foundation
import Combine

class FavoriteMovieCellViewModel {
    
    @Published var imageData: Data?
    var cancellables = Set<AnyCancellable>()
    private let movie: Movie
    private let networkingManager: NetworkingManager
    
    init(movie: Movie, networkingManager: NetworkingManager = .shared) {
        self.movie = movie
        self.networkingManager = networkingManager
        loadImage()
    }
    
    private func loadImage() {
        guard let posterPath = movie.posterPath else { return }
        
        networkingManager.loadJustBanner(from: posterPath)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Erro ao carregar imagem: \(error.localizedDescription)")
                    print("Erro ao carregar imagem: \(error)")
                }
            }, receiveValue: { [weak self] data in
                self?.imageData = data
            })
            .store(in: &cancellables)
    }
}
