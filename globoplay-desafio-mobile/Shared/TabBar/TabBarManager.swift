//
//  TabBarManager.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 28/01/25.
//

import SwiftUI
import Foundation
import UIKit

struct TabItem<Content: View> {
    let title: String
    let icon: String
    let view: Content
}

class TabBarManager: ObservableObject {
    private var coordinator: AppCoordinator
    @Published var tabs: [TabItem<AnyView>] = []
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
        
        let homeViewModel = HomeViewModel(coordinator: coordinator)
        let homeView = AnyView(HomeView(viewModel: homeViewModel))
        
        let favoritesViewModel = FavoritesViewModel()
        favoritesViewModel.fetchFavoriteMovies()
        
        let favoritesViewController = FavoritesViewController()
        favoritesViewController.viewModel = favoritesViewModel
        
        let favoritesView = AnyView(FavoritesViewControllerRepresentable(viewController: favoritesViewController))
        
        tabs = [
            TabItem(title: "Início", icon: "house", view: homeView),
            TabItem(title: "Favoritos", icon: "star", view: favoritesView),
        ]
    }
}
