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
    
    func getNowPlaying() {
        isLoading = true
        networkingManager.getData(from: .nowPlaying, showAlert: { [weak self] message in
            self?.errorMessage = message
        })
        .sink(receiveCompletion: { [weak self] completion in
            self?.isLoading = false
            if case .failure(let error) = completion {
                self?.errorMessage = error.localizedDescription
            }
        }, receiveValue: { [weak self] movieResponse in
            self?.nowPlayingMovies = movieResponse.results
        })
        .store(in: &cancellables)
    }

    func getPopular() {
        isLoading = true
        networkingManager.getData(from: .popular, showAlert: { [weak self] message in
            self?.errorMessage = message
        })
        .sink(receiveCompletion: { [weak self] completion in
            self?.isLoading = false
            if case .failure(let error) = completion {
                self?.errorMessage = error.localizedDescription
            }
        }, receiveValue: { [weak self] movieResponse in
            self?.popularMovies = movieResponse.results
        })
        .store(in: &cancellables)
    }

    func getTopRated() {
        isLoading = true
        networkingManager.getData(from: .topRated, showAlert: { [weak self] message in
            self?.errorMessage = message
        })
        .sink(receiveCompletion: { [weak self] completion in
            self?.isLoading = false
            if case .failure(let error) = completion {
                self?.errorMessage = error.localizedDescription
            }
        }, receiveValue: { [weak self] movieResponse in
            self?.topRatedMovies = movieResponse.results
            if let dates = movieResponse.dates {
                print("Data mínima: \(dates.minimum), Data máxima: \(dates.maximum)")
            }
        })
        .store(in: &cancellables)
    }

    func getUpcoming() {
        isLoading = true
        networkingManager.getData(from: .upcoming, showAlert: { [weak self] message in
            self?.errorMessage = message
        })
        .sink(receiveCompletion: { [weak self] completion in
            self?.isLoading = false
            if case .failure(let error) = completion {
                self?.errorMessage = error.localizedDescription
            }
        }, receiveValue: { [weak self] movieResponse in
            self?.upcomingMovies = movieResponse.results
        })
        .store(in: &cancellables)
    }
    
    func selectMovie(_ movie: Movie) {
        print("Movie selected: \(movie.title)")
        coordinator.showMovieDetails(movie: movie)
    }
}
