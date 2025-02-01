//
//  MainTabView.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 28/01/25.
//

import SwiftUI

struct MainTabView: View {
    @ObservedObject var tabBarManager: TabBarManager
    @State private var selectedTab = 0
    
    init(coordinator: AppCoordinator) {
        _tabBarManager = ObservedObject(wrappedValue: TabBarManager(coordinator: coordinator))
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(tabBarManager.tabs.indices, id: \.self) { index in
                tabBarManager.tabs[index].view
                    .tabItem {
                        
                        Image(systemName: selectedTab == index ? tabBarManager.tabs[index].icon + ".fill" : tabBarManager.tabs[index].icon)
                        Text(tabBarManager.tabs[index].title)
                    }
                    .tag(index)
            }
        }
        .accentColor(Color.textColor)
        .onAppear {
            UITabBar.appearance().backgroundColor = .black
        }
    }
}
