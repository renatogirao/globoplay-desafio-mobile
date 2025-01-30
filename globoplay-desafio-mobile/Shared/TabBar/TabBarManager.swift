//
//  TabBarManager.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 28/01/25.
//

import SwiftUI
import Foundation

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
        UITabBar.appearance().barTintColor = UIColor(Color.appBackground)
        UITabBar.appearance().tintColor = UIColor(Color.textColor)
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
        
        let homeViewModel = HomeViewModel(coordinator: coordinator)
        tabs = [
            TabItem(title: "Início", icon: "house", view: AnyView(HomeView(viewModel: homeViewModel))),
            TabItem(title: "Favoritos", icon: "star", view: AnyView(FavoritesView()))
        ]
    }

    func addTab(title: String, icon: String, view: AnyView) {
        tabs.append(TabItem(title: title, icon: icon, view: view))
    }
}


