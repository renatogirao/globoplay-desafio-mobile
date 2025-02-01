//
//  MovieDetailsViewModel.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 29/01/25.
//

import Combine
import UIKit
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
    
    init(movie: Movie) {
        self.movie = movie
        self.isFavorite = movieRepository.isFavorite(movieId: movie.id)
        self.context = CoreDataManager.shared.context
    }
    
    func fetchMovieDetails(movieId: Int) {
        isLoading = true
        networkingManager.getMovieDetails(movieId: movieId)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                    print("Erro na fetchMovieDetails na ViewModel: \(error.localizedDescription)\n\n")
                }
            }, receiveValue: { [weak self] movieDetails in
                self?.movieDetails = movieDetails
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
    
    func addFavorite(movie: Movie) {
            let fetchRequest: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", String(movie.id))

            do {
                let existingMovies = try context.fetch(fetchRequest)
                if existingMovies.isEmpty {
                    let favorite = FavoriteMovie(context: context)
                    favorite.id = Int64(movie.id)
                    favorite.title = movie.title
                    favorite.posterPath = movie.posterPath
                    favorite.releaseDate = movie.releaseDate
                    if let voteAverage = movie.voteAverage {
                        favorite.voteAverage = voteAverage
                    } else {
                        print("Avaliação do filme não disponível.")
                    }

                    saveContext()
                    self.isFavorite = true
                } else {
                    print("Este filme já foi adicionado aos favoritos.")
                    self.isFavorite = true
                }
            } catch {
                print("Erro ao adicionar favorito: \(error.localizedDescription)")
            }
        }

        private func saveContext() {
            do {
                try context.save()
            } catch {
                print("Erro ao salvar contexto: \(error.localizedDescription)")
            }
        }
    
    func watchMovie() {
        // implementar a fuctionalidade para assistir o filme
    }
}
