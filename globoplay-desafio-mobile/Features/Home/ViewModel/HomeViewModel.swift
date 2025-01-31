//
//  HomeViewModel.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 28/01/25.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    private let networkingManager = NetworkingManager()
    private let coordinator: AppCoordinator
    
    @Published var selectedMovie: Movie?
    @Published var nowPlayingMovies: [Movie] = []
    @Published var popularMovies: [Movie] = []
    @Published var topRatedMovies: [Movie] = []
    @Published var upcomingMovies: [Movie] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    var sections: [MovieSection] {
        return [
            MovieSection(title: "Now Playing", movies: nowPlayingMovies),
            MovieSection(title: "Popular", movies: popularMovies),
            MovieSection(title: "Top Rated", movies: topRatedMovies),
            MovieSection(title: "Upcoming", movies: upcomingMovies)
        ]
    }
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    func fetchMovies(endpoint: APIEndpoint, assignTo moviesList: @escaping ([Movie]) -> Void) {
        isLoading = true
        networkingManager.getData(from: endpoint, showAlert: { [weak self] message in
            self?.errorMessage = message
        })
        .sink(receiveCompletion: { [weak self] completion in
            self?.isLoading = false
            if case .failure(let error) = completion {
                self?.errorMessage = error.localizedDescription
            }
        }, receiveValue: { moviesResponse in
            moviesList(moviesResponse.results)
        })
        .store(in: &cancellables)
    }
    
    func getNowPlaying() {
        fetchMovies(endpoint: .nowPlaying) { [weak self] movies in
            self?.nowPlayingMovies = movies
        }
    }

    func getPopular() {
        fetchMovies(endpoint: .popular) { [weak self] movies in
            self?.popularMovies = movies
        }
    }

    func getTopRated() {
        fetchMovies(endpoint: .topRated) { [weak self] movies in
            self?.topRatedMovies = movies
        }
    }

    func getUpcoming() {
        fetchMovies(endpoint: .upcoming) { [weak self] movies in
            self?.upcomingMovies = movies
        }
    }
}
