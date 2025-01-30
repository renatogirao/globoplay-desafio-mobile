//
//  MainTabView.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 28/01/25.
//

import SwiftUI

struct MainTabView: View {
    @ObservedObject var tabBarManager: TabBarManager
    
    init(coordinator: AppCoordinator) {
        _tabBarManager = ObservedObject(wrappedValue: TabBarManager(coordinator: coordinator))
    }

    var body: some View {
        TabView {
            ForEach(tabBarManager.tabs, id: \.title) { tab in
                tab.view
                    .tabItem {
                        Image(systemName: tab.icon)
                        Text(tab.title)
                    }
            }
        }
        .accentColor(Color.textColor)
    }
}
