//
//  TabBarManager.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 28/01/25.
//

import SwiftUI
import Foundation

class TabBarManager: ObservableObject {
    @Published var tabs: [TabItem] = [
        TabItem(title: "Início", icon: "house", view: AnyView(HomeView())),
        TabItem(title: "Favoritos", icon: "star", view: AnyView(FavoritesView()))
    ]
    
    func addTab(title: String, icon: String, view: AnyView) {
        tabs.append(TabItem(title: title, icon: icon, view: view))
    }
}

struct TabItem {
    let title: String
    let icon: String
    let view: AnyView
}
