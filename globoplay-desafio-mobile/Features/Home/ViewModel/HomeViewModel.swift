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
    
    @Published var nowPlayingMovies: [Movie] = []
    @Published var popularMovies: [Movie] = []
    @Published var topRatedMovies: [Movie] = []
    @Published var upcomingMovies: [Movie] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    var sections: [Section] {
        return [
            Section(title: "Now Playing", items: nowPlayingMovies),
            Section(title: "Popular", items: popularMovies),
            Section(title: "Top Rated", items: topRatedMovies),
            Section(title: "Upcoming", items: upcomingMovies)
        ]
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
    }}
