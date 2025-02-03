//
//  FavoritesCoordinator.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 31/01/25.
//

import UIKit

class FavoritesCoordinator {
    
    private var navigationController: UINavigationController
    private var favoritesViewController: FavoritesViewController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.favoritesViewController = FavoritesViewController()
    }
    
    func start() {
        favoritesViewController.coordinator = self
        navigationController.pushViewController(favoritesViewController, animated: true)
    }
    
    func showFavoritesDetails(for movie: Movie) {
        let detailsViewController = FavoritesMovieDetailsViewController()
        detailsViewController.movie = movie
        navigationController.pushViewController(detailsViewController, animated: true)
    }
}
