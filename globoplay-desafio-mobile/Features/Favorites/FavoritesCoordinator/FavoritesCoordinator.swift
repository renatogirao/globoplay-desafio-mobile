//
//  FavoritesCoordinator.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 31/01/25.
//

import UIKit

class FavoritesCoordinator: FavoritesCoordinatorDelegate {
    
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let favoritesVC = FavoritesViewController()
        favoritesVC.coordinator = self 
        navigationController.pushViewController(favoritesVC, animated: true)
    }

    func showMovieDetails(movie: Movie) {
        let detailsVC = FavoritesMovieDetailsViewController(movie: movie)
        navigationController.pushViewController(detailsVC, animated: true)
    }
}
