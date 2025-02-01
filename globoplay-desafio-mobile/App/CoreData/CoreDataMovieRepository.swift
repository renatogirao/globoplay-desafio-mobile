//
//  CoreDataMovieRepository.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 31/01/25.
//

import Foundation
import CoreData

class MovieCoreDataRepository {
    
    // MARK: - Properties
    private let context = CoreDataManager.shared.context
    
    // MARK: - Methods
    
    func saveFavorite(movie: Movie) {
        let favorite = FavoriteMovie(context: context)
        favorite.id = Int64(movie.id)
        favorite.title = movie.title
        favorite.posterPath = movie.posterPath
        favorite.overview = movie.overview
        
        CoreDataManager.shared.saveContext()
    }
    
    func getFavorites(completion: @escaping (Result<[Movie], Error>) -> Void) {
        let fetchRequest: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)
            let movies = results.map { entity in
                Movie(
                    id: Int(bitPattern: entity.id),
                    title: entity.title ?? "",
                    posterPath: entity.posterPath,
                    overview: entity.overview,
                    backdropPath: entity.backdropPath,
                    genreIds: entity.genreIds as? [Int],
                    voteCount: Int(entity.voteCount),
                    adult: entity.adult,
                    releaseDate: entity.releaseDate ?? "",
                    originalLanguage: entity.originalLanguage,
                    originalTitle: entity.originalTitle,
                    popularity: entity.popularity,
                    video: entity.video,
                    voteAverage: entity.voteAverage
                )
            }
            completion(.success(movies))
            print("CoreData getFavorites: \(results.count) movies found")
        } catch {
            print("Erro atualizando os favoritos dop CoreData: \(error.localizedDescription)")
            completion(.failure(error))
        }
    }
    
    func removeFavorite(movieId: Int) {
        let fetchRequest: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", movieId)
        
        do {
            let results = try context.fetch(fetchRequest)
            if let movieToDelete = results.first {
                context.delete(movieToDelete)
                CoreDataManager.shared.saveContext()
            }
        } catch {
            print("Erro ao remover favorito: \(error.localizedDescription)")
        }
    }
    
    func isFavorite(movieId: Int) -> Bool {
        let fetchRequest: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", movieId)
        
        do {
            let count = try context.count(for: fetchRequest)
            return count > 0
        } catch {
            return false
        }
    }
}
