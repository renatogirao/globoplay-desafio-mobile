//
//  FavoritesMovieDetailsView.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 31/01/25.
//

import UIKit

class FavoritesMovieDetailsView: UIViewController {
    
    private var movie: Movie
    private var details: MovieDetails?
    private var isLoading = true
    private var activityIndicator: UIActivityIndicatorView!
    
    private var titleLabel: UILabel!
    private var backdropImageView: UIImageView!
    private var ratingLabel: UILabel!
    private var overviewLabel: UILabel!
    private var releaseDateLabel: UILabel!
    
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        fetchMovieDetails()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        
        backdropImageView = UIImageView()
        backdropImageView.translatesAutoresizingMaskIntoConstraints = false
        backdropImageView.contentMode = .scaleAspectFill
        backdropImageView.clipsToBounds = true
        view.addSubview(backdropImageView)
        
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = .white
        view.addSubview(titleLabel)
        
        ratingLabel = UILabel()
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.font = UIFont.systemFont(ofSize: 18)
        ratingLabel.textColor = .white
        view.addSubview(ratingLabel)
        
        overviewLabel = UILabel()
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        overviewLabel.font = UIFont.systemFont(ofSize: 16)
        overviewLabel.textColor = .white
        overviewLabel.numberOfLines = 0
        view.addSubview(overviewLabel)
        
        releaseDateLabel = UILabel()
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseDateLabel.font = UIFont.systemFont(ofSize: 16)
        releaseDateLabel.textColor = .white
        view.addSubview(releaseDateLabel)
        
        NSLayoutConstraint.activate([
            backdropImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backdropImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backdropImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backdropImageView.heightAnchor.constraint(equalToConstant: 250),
            
            titleLabel.topAnchor.constraint(equalTo: backdropImageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            ratingLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            ratingLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            ratingLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            overviewLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 16),
            overviewLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            overviewLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            releaseDateLabel.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 16),
            releaseDateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            releaseDateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
        ])
    }
    
    private func fetchMovieDetails() {
        activityIndicator.startAnimating()
        
        NetworkingManager.shared.getMovieDetails(movieId: movie.id) { [weak self] result in
            self?.activityIndicator.stopAnimating()
            
            switch result {
            case .success(let movieDetails):
                self?.details = movieDetails
                self?.updateUI()
            case .failure(let error):
                print("Erro ao obter detalhes: \(error.localizedDescription)")
            }
        }
    }
    
    private func updateUI() {
        guard let details = details else { return }
        
        titleLabel.text = details.title
        ratingLabel.text = "⭐ Rating: \(details.voteAverage ?? 0, specifier: "%.1f") / 10"
        overviewLabel.text = details.overview
        releaseDateLabel.text = "Release Date: \(details.releaseDate ?? "N/A")"
        
        if let backdropPath = details.backdropPath, let url = URL(string: "https://image.tmdb.org/t/p/original\(backdropPath)") {
            backdropImageView.loadImage(from: url)
        }
    }
}
