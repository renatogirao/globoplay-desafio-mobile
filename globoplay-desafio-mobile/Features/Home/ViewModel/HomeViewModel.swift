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
    @Published var movieGenres: [Genre] = []
    @Published var actorsAndActresses: [Person] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    func fetchNowPlaying() {
        isLoading = true
        networkingManager.getData(from: .nowPlaying, type: [Movie].self)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] movies in
                self?.nowPlayingMovies = movies
            })
            .store(in: &cancellables)
    }

    func fetchPopular() {
        isLoading = true
        networkingManager.getData(from: .popular, type: [Movie].self)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] movies in
                self?.popularMovies = movies
            })
            .store(in: &cancellables)
    }

    func fetchTopRated() {
        isLoading = true
        networkingManager.getData(from: .topRated, type: [Movie].self)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] movies in
                self?.topRatedMovies = movies
            })
            .store(in: &cancellables)
    }

    func fetchUpcoming() {
        isLoading = true
        networkingManager.getData(from: .upcoming, type: [Movie].self)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] movies in
                self?.upcomingMovies = movies
            })
            .store(in: &cancellables)
    }

    
    func getGenres() {
        isLoading = true
        networkingManager.getData(from: .genres, type: [Genre].self)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] genres in
                self?.movieGenres = genres
            })
            .store(in: &cancellables)
    }

    func getTrendingPeople() {
        isLoading = true
        networkingManager.getData(from: .trendingPeople, type: [Person].self)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] people in
                self?.actorsAndActresses = people
            })
            .store(in: &cancellables)
    }

}
