//
//  CoreDataMovieRepository.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 31/01/25.
//

import Foundation
import CoreData

class MovieCoreDataRepository {
    private let context = CoreDataManager.shared.context

    func saveFavorite(movie: Movie) {
        let favorite = FavoriteMovie(context: context)
        favorite.id = Int64(movie.id)
        favorite.title = movie.title
        favorite.posterPath = movie.posterPath
        favorite.overview = movie.overview
        
        CoreDataManager.shared.saveContext()
    }

    func getFavorites() -> [Movie] {
        let fetchRequest: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)
            return results.map { entity in
                Movie(
                    id: Int(entity.id),
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
        } catch {
            print("Erro ao pegar os favoritos do CoreData: \(error.localizedDescription)")
            return []
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
