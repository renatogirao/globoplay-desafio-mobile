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
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor(Color.navigationBarBackground)
        navBarAppearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor(Color.textColor)
        ]
        navBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor(Color.textColor)
        ]
        
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance

        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor(Color.tabBarBackground)
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = UIColor.lightGray
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = UIColor.white

        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        UITabBar.appearance().tintColor = .white
        
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
