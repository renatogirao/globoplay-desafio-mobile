//
//  MovieCell.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 28/01/25.
//

import SwiftUI

struct MovieCell: View {
    let movie: Movie
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .frame(width: 120, height: 180)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 180)
                        .cornerRadius(8)
                        .clipped()
                case .failure:
                    Image(systemName: "photo.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 180)
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }
                .font(.caption)
                .lineLimit(2)
                .frame(maxWidth: 120)
        }
        .onAppear {
            let imageUrlString = "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")"
            print("Image URL: \(imageUrlString)")
        }
    }
}

struct MovieCell_Previews: PreviewProvider {
    static var previews: some View {
        MovieCell(movie: Movie(id: 123, title: "teste", posterPath: "teste", overview: "teste", backdropPath: "teste", genreIds: [1,2,3], voteCount: 9, adult: true, releaseDate: "teste", originalLanguage: "teste", originalTitle: "teste", popularity: 23.2, video: true, voteAverage: 4.3))
    }
}
