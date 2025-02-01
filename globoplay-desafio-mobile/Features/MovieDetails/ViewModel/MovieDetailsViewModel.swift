//
//  MovieDetailsViewModel.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 29/01/25.
//

import Combine
import UIKit
import AVKit
import CoreData

class MovieDetailsViewModel: ObservableObject {
    
    var cancellables = Set<AnyCancellable>()
    
    private let networkingManager = NetworkingManager()
    private let movieRepository = MovieCoreDataRepository()
    
    private var context: NSManagedObjectContext
    
    @Published var isFavorite: Bool = false
    @Published var movieDetails: MovieDetails?
    @Published var movie: Movie
    @Published var relatedMovies: [Movie] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var movieTrailerURL: URL?
    
    init(movie: Movie) {
        self.movie = movie
        self.isFavorite = movieRepository.isFavorite(movieId: movie.id)
        self.context = CoreDataManager.shared.context
        fetchMovieVideos()
    }
    
    func fetchMovieDetails(movieId: Int) {
        isLoading = true
        networkingManager.getMovieDetails(movieId: movieId)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] movieDetails in
                self?.movieDetails = movieDetails
            })
            .store(in: &cancellables)
    }

    func fetchMovieVideos() {
        networkingManager.getMovieVideos(movieId: movie.id)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Erro ao buscar vídeos: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] response in
                if let trailer = response.results.first(where: { $0.site == "YouTube" }) {
                    self?.movieTrailerURL = URL(string: "https://www.youtube.com/watch?v=\(trailer.key)")
                }
            })
            .store(in: &cancellables)
    }
    
    func toggleFavorite() {
        if isFavorite {
             movieRepository.removeFavorite(movieId: movie.id)
         } else {
             movieRepository.saveFavorite(movie: movie)
         }
         isFavorite.toggle()
    }

    func watchMovie() {
        guard let trailerURL = movieTrailerURL else {
            print("Erro: URL do trailer não encontrada.")
            return
        }
        print("URL do trailer: \(trailerURL)")
        DispatchQueue.main.async {
            if !trailerURL.isValidURL {
                print("Erro: URL do trailer inválida.")
                return
            }
            
            let player = AVPlayer(url: trailerURL)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player

            if let player = playerViewController.player {
                print("Player criado com sucesso.")
            } else {
                print("Erro: Falha ao criar o player.")
            }

            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                print("WindowScene encontrada: \(windowScene)")
                
                if let window = windowScene.windows.first {
                    print("Janela encontrada: \(window)")
                    
                    if let rootViewController = window.rootViewController {
                        print("RootViewController encontrado: \(rootViewController)")
                        
                        rootViewController.present(playerViewController, animated: true) {
                            print("Iniciando o trailer...")
                            player.play()
                        }
                    } else {
                        print("Erro: RootViewController não encontrada")
                    }
                } else {
                    print("Erro: Janela não encontrad")
                }
            } else {
                print("Erro: WindowScene não encontrada")
            }
        }
    }
}
