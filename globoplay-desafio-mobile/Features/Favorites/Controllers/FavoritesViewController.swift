//
//  FavoritesViewController.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 31/01/25.
//

import UIKit
import Foundation
import SwiftUI

protocol FavoritesCoordinatorDelegate: AnyObject {
    func showMovieDetails(movie: Movie)
}

class FavoritesViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel: FavoritesViewModel!
    private var favoritesView: FavoritesView!
    weak var coordinator: FavoritesCoordinator?

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let viewModel = viewModel else {
            print("ViewModel não está configurado!")
            return
        }
        
        setupView()
        bindViewModel()
        print("\\n\nFavoritesViewController APARECEU\n\n")
        viewModel.fetchFavoriteMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("FavoritesViewController viewWillAppear")
    }

    // MARK: - Setup
    private func setupView() {
        favoritesView = FavoritesView(viewModel: viewModel)
        view.addSubview(favoritesView)
        navigationItem.title = "Favoritos"
        
        favoritesView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favoritesView.topAnchor.constraint(equalTo: view.topAnchor),
            favoritesView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favoritesView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            favoritesView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }


    // MARK: - Binding
    private func bindViewModel() {
           viewModel.onMoviesLoaded = { [weak self] in
               self?.favoritesView.updateMovies(self?.viewModel.favoriteMovies ?? [])
           }
           
           viewModel.onError = { [weak self] error in
               // fazer handle de erro! Alerta?
           }
       }
}
