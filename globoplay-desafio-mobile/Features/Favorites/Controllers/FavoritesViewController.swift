//
//  FavoritesViewController.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 31/01/25.
//

import UIKit
import Foundation
import SwiftUI
import Combine

class FavoritesViewController: UIViewController {
    
    var viewModel: FavoritesViewModel!
    private var favoritesView: FavoritesView!
    weak var coordinator: FavoritesCoordinator?
    
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let viewModel = viewModel else {
            print("ViewModel não está configurado!")
            return
        }
        
        setupView()
        bindViewModel()
        viewModel.fetchFavoriteMovies()
    }
    
    private func setupView() {
        favoritesView = FavoritesView(viewModel: viewModel)
        view.addSubview(favoritesView)
        
        if let navigationController = navigationController {
            navigationController.navigationBar.prefersLargeTitles = true
            navigationItem.title = "Favoritos"
        }
        
        favoritesView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favoritesView.topAnchor.constraint(equalTo: view.topAnchor),
            favoritesView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favoritesView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            favoritesView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func bindViewModel() {
        viewModel.$favoriteMovies
            .sink { [weak self] movies in
                self?.favoritesView.updateMovies(movies)
            }
            .store(in: &cancellables)
        
        viewModel.onMoviesLoaded = { [weak self] in
            self?.favoritesView.stopLoading()
        }
        
        viewModel.onError = { error in
            print("Error loading movies: \(error)")
        }
        
        favoritesView.didSelectMovie = { [weak self] movie in
            self?.coordinator?.showFavoritesDetails(for: movie)
        }
    }
}
