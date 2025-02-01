//
//  AppCoordinator.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 29/01/25.
//

import UIKit
import SwiftUI
import Combine

class AppCoordinator: ObservableObject, Coordinator {
    var window: UIWindow
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
    private var cancellables = Set<AnyCancellable>()

    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
        self.tabBarController = UITabBarController()
        start()
    }
    
    func start() {
        // Home
        let homeViewModel = HomeViewModel(coordinator: self)
        let homeView = HomeView(viewModel: homeViewModel)
        let homeViewController = UIHostingController(rootView: homeView)
        
        // Favorites
        let favoritesCoordinator = FavoritesCoordinator(navigationController: navigationController) // Usando o navigationController principal
        favoritesCoordinator.start()
        
        let homeTab = UINavigationController(rootViewController: homeViewController)
        homeTab.tabBarItem = UITabBarItem(title: "Início", image: UIImage(systemName: "house"), tag: 0)
        
        let favoritesTab = navigationController // Usando o navigationController principal
        favoritesTab.tabBarItem = UITabBarItem(title: "Favoritos", image: UIImage(systemName: "star"), tag: 1)
        
        tabBarController.viewControllers = [homeTab, favoritesTab]
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
    
    func showMovieDetails(movie: Movie) {
        print("Indo buscar os detalhes do filme antes de abrir a tela...")

        NetworkingManager.shared.getMovieDetails(movieId: movie.id)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Erro ao carregar detalhes do filme: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] details in
                print("Detalhes do filme carregados. Agora indo para a tela.")

                let movieDetailsView = MovieDetailsView(movie: movie)

                let detailsViewController = UIHostingController(rootView: movieDetailsView)
                self?.navigationController.pushViewController(detailsViewController, animated: true)
            })
            .store(in: &cancellables)
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
}
