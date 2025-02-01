//
//  FavoritesViewController.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 31/01/25.
//

import UIKit
import Foundation

protocol FavoritesCoordinatorDelegate: AnyObject {
    func showMovieDetails(movie: Movie)
}

import SwiftUI

class FavoritesViewController: UIViewController {

    // MARK: - Properties
    private var viewModel: FavoritesViewModel!
    private var favoritesViewRepresentable: FavoritesViewRepresentable!
    weak var coordinator: FavoritesCoordinator?

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
        viewModel.fetchFavoriteMovies()
        print("\\n\nFavoritesViewController APARECEU\n\n")
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            print("FavoritesViewController viewWillAppear")
        }

    // MARK: - Setup
    private func setupView() {
        favoritesViewRepresentable = FavoritesViewRepresentable(movies: [])
        
        let hostingController = UIHostingController(rootView: favoritesViewRepresentable)
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.view.frame = view.bounds
        hostingController.didMove(toParent: self)
    }

    // MARK: - Binding
    private func bindViewModel() {
        viewModel.onMoviesLoaded = { [weak self] in
            self?.favoritesViewRepresentable.movies = self?.viewModel.favoriteMovies ?? []
        }
        viewModel.onError = { [weak self] error in
            // TODO - fazer handle do errro
        }
    }
}
