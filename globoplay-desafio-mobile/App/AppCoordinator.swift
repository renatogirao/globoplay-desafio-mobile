//
//  AppCoordinator.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 29/01/25.
//

import UIKit
import SwiftUI
import Combine

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}

class AppCoordinator: ObservableObject {
    var window: UIWindow
    var tabBarController: UITabBarController?

    init(window: UIWindow) {
        self.window = window
        self.tabBarController = UITabBarController()
    }

    func start() {
        let homeViewModel = HomeViewModel(coordinator: self)
        let homeView = HomeView(viewModel: homeViewModel)
        let homeViewController = UIHostingController(rootView: homeView)
        
        let favoritesViewController = FavoritesViewController()
        
        let homeNavController = UINavigationController(rootViewController: homeViewController)
        let favoritesNavController = UINavigationController(rootViewController: favoritesViewController)
        
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        favoritesViewController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star"), tag: 1)
        
        tabBarController?.viewControllers = [homeNavController, favoritesNavController]
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}
