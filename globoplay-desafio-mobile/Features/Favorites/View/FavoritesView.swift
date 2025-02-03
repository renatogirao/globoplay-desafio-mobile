//
//  FavoritesView.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 28/01/25.
//

import UIKit
import Combine

class FavoritesView: UIView {
    
    var didSelectMovie: ((Movie) -> Void)?
    private var viewModel: FavoritesViewModel
    private var cancellables = Set<AnyCancellable>()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private var movies: [Movie] = []
    
    init(viewModel: FavoritesViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupView()
        bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(collectionView)
        addSubview(loadingIndicator)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FavoriteMovieCell.self, forCellWithReuseIdentifier: FavoriteMovieCell.identifier)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func bindViewModel() {
        viewModel.$favoriteMovies
            .sink { [weak self] movies in
                self?.updateMovies(movies)
            }
            .store(in: &cancellables)
        
        viewModel.onMoviesLoaded = { [weak self] in
            self?.stopLoading()
        }
        
        viewModel.onError = { error in
            print("Error loading movies: \(error)")
        }
    }
    
    func updateMovies(_ movies: [Movie]) {
        self.movies = movies
        collectionView.reloadData()
    }
    
    func startLoading() {
        loadingIndicator.startAnimating()
    }
    
    func stopLoading() {
        loadingIndicator.stopAnimating()
    }
}

extension FavoritesView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteMovieCell.identifier, for: indexPath) as? FavoriteMovieCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: movies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectMovie?(movies[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 48) / 3
        let height = width * 1.5
        return CGSize(width: width, height: height)
    }
}
