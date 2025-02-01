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
    
    @StateObject private var viewModel: MovieDetailsViewModel
    
    init(movie: Movie) {
        self.movie = movie
        _viewModel = StateObject(wrappedValue: MovieDetailsViewModel(movie: movie))
    }
    
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
        ZStack {
            if let posterPath = details?.posterPath, let url = URL(string: "https://image.tmdb.org/t/p/original\(posterPath)") {
                AsyncImage(url: url) { image in
                    image.resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                        .edgesIgnoringSafeArea(.all)
                        .blur(radius: 20)
                } placeholder: {
                    Color.black
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                        .edgesIgnoringSafeArea(.all)
                        .blur(radius: 20)
                }
            }
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    if isLoading {
                        ProgressView("Carregando...")
                            .progressViewStyle(CircularProgressViewStyle())
                            .padding()
                    } else {
                        if let backdropPath = details?.backdropPath, let url = URL(string: "https://image.tmdb.org/t/p/original\(backdropPath)") {
                            AsyncImage(url: url) { image in
                                image.resizable()
                                    .scaledToFit()
                                    .frame(height: 220)
                                    .cornerRadius(22)
                                    .shadow(radius: 8)
                                    .padding(.horizontal, 12)
                                    .padding(.top, 12)
                            } placeholder: {
                                Color.gray.frame(height: 220)
                                    .cornerRadius(16)
                                    .shadow(radius: 8)
                                    .padding(.horizontal, 12)
                                    .padding(.top, 12)
                            }
                        }
                        
                        Text(details?.title ?? "Título desconhecido")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .padding(.top, 16)
                            .shadow(color: .black, radius: 5, x: 0, y: 2)
                        
                        Text("⭐ Rating: \(details?.voteAverage ?? 0, specifier: "%.1f") / 10")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .shadow(color: .black, radius: 5, x: 0, y: 2)
                        
                        Text(details?.overview ?? "Descrição não disponível.")
                            .font(.body)
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .shadow(color: .black, radius: 5, x: 0, y: 2)
                        
                        Text("Release Date: \(details?.releaseDate ?? "Data não disponível")")
                            .font(.body)
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .shadow(color: .black, radius: 5, x: 0, y: 2)
                        Spacer()
                        HStack(spacing: 12) {
                            Button(action: {
                                viewModel.toggleFavorite()
                            }) {
                                HStack {
                                    Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                                        .foregroundColor(viewModel.isFavorite ? .red : .white)
                                    Text("Favoritar")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red.opacity(0.7))
                                .cornerRadius(12)
                            }
                            
                            Button(action: {
                                viewModel.watchMovie()
                            }) {
                                Text("Assistir")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.blue)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(12)
                            }
                            .disabled(viewModel.movieTrailerURL == nil)
                            .opacity(viewModel.movieTrailerURL == nil ? 0.5 : 1.0)
                        }
                        .padding(.horizontal, 12)
                        .padding(.top, 16)
                    }
                }
                .padding(.bottom, 100)
                .padding(.top, 88)
            }
        }
        .navigationTitle("Detalhes do Filme")
        .onAppear {
            fetchMovieDetails()
        }
    }
}
