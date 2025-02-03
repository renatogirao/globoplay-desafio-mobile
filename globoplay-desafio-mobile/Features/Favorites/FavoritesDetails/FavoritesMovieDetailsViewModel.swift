//
//  FavoritesMovieDetailsViewModel.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 31/01/25.
//

import Foundation
import Combine

class FavoritesMovieDetailsViewModel: ObservableObject {
    @Published var movie: Movie?
    private var cancellables = Set<AnyCancellable>()
    
    func fetchMovieDetails() {
   
        
    }
}
