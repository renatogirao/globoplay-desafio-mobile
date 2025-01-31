//
//  FavoritesView.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 28/01/25.
//

import UIKit
import CoreData

class FavoritesView: UIViewController {
    
    private var viewModel: FavoritesViewModel!
    private var collectionView: UICollectionView!
    private var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        viewModel = FavoritesViewModel()
        fetchFavoriteMovies()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (view.bounds.width - 40) / 2, height: 250)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FavoriteMovieCell.self, forCellWithReuseIdentifier: FavoriteMovieCell.reuseIdentifier)
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func fetchFavoriteMovies() {
        activityIndicator.startAnimating()
        viewModel.fetchFavoriteMovies { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.collectionView.reloadData()
        }
    }
}

extension FavoritesView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.favoriteMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteMovieCell.reuseIdentifier, for: indexPath) as! FavoriteMovieCell
        let movie = viewModel.favoriteMovies[indexPath.item]
        cell.configure(with: movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = viewModel.favoriteMovies[indexPath.item]
        let detailsViewController = FavoritesMovieDetailsView(movie: movie)
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
