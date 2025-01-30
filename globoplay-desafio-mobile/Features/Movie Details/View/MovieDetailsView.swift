//
//  MovieDetailsView.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 30/01/25.
//

import SwiftUI
import Combine

struct MovieDetailsView: View {
    var movie: Movie
    @State private var details: MovieDetails?
    @State private var isLoading = true
    @State private var cancellable: AnyCancellable?

    private func fetchMovieDetails() {
        cancellable = NetworkingManager.shared.getMovieDetails(movieId: movie.id)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Erro ao obter detalhes do filme: \(error.localizedDescription)")
                    self.isLoading = false
                }
            }, receiveValue: { movieDetails in
                self.details = movieDetails
                self.isLoading = false
            })
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if isLoading {
                    ProgressView("Carregando...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else {
                    if let backdropPath = details?.backdropPath, let url = URL(string: "https://image.tmdb.org/t/p/original\(backdropPath)") {
                        AsyncImage(url: url) { image in
                            image.resizable()
                                .scaledToFill()
                                .frame(height: 250)
                                .clipped()
                        } placeholder: {
                            Color.gray
                                .frame(height: 250)
                        }
                    }
                    
                    Text(details?.title ?? "Título desconhecido")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top)
                    
                    Text("⭐ Rating: \(details?.voteAverage ?? 0, specifier: "%.1f") / 10")
                        .font(.subheadline)
                        .padding(.top, 4)
                    
                    Text(details?.overview ?? "Descrição não disponível.")
                        .font(.body)
                        .padding(.top)
                    
                    Text("Release Date: \(details?.releaseDate ?? "Data não disponível")")
                        .font(.body)
                        .padding(.top, 8)
                    
                    Spacer()
                    
                    HStack {
                        Button(action: {
                            // TODO - Adicionar lógica para favoritar o filme
                        }) {
                            Text("Favoritar")
                                .font(.headline)
                                .foregroundColor(.blue)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            // TODO - Adicionar lógica para assistir o filme
                        }) {
                            Text("Assistir")
                                .font(.headline)
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.top, 16)
                }
            }
            .padding()
        }
        .navigationTitle("Detalhes do Filme")
        .onAppear {
            fetchMovieDetails()
        }
    }
}

//struct MovieDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieDetailsView(movie: Movie(id: 1, title: "Movie Title", posterPath: nil, overview: nil, backdropPath: nil, genreIds: nil, voteCount: nil, adult: nil, releaseDate: "2023-01-01", originalLanguage: "en", originalTitle: "Original Movie", popularity: nil, video: nil, voteAverage: nil), details: MovieDetails.default)
//    }
//}
