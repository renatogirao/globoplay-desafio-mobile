//
//  FavoritesMovieDetailsViewController.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 31/01/25.
//

import UIKit
import Combine

class FavoritesMovieDetailsViewController: UIViewController {
    
    var movie: Movie!
    private var movieDetailsView: FavoritesMovieDetailsView!
    private var movieDetails: MovieDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        fetchMovieDetails()
    }
    
    private func setupView() {
        movieDetailsView = FavoritesMovieDetailsView()
        view.addSubview(movieDetailsView)
        
        movieDetailsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieDetailsView.topAnchor.constraint(equalTo: view.topAnchor),
            movieDetailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieDetailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieDetailsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func fetchMovieDetails() {
        movieDetailsView.startLoading()
        
//        let details = MovieDetails(
//            title: movie.title,
//            voteAverage: movie.voteAverage,
//            overview: movie.overview,
//            releaseDate: movie.releaseDate,
//            backdropPath: movie.backdropPath
//        )
        
//        movieDetails = details
//        movieDetailsView.updateUI(with: details)
//        movieDetailsView.stopLoading()
    }
}
