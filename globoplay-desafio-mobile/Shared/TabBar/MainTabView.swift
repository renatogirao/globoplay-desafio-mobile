//
//  MainTabView.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 28/01/25.
//

import SwiftUI

struct MainTabView: View {
    @StateObject private var tabBarManager = TabBarManager()
    
    var body: some View {
        TabView {
            ForEach(tabBarManager.tabs, id: \.title) { tab in
                tab.view
                    .tabItem {
                        Label(tab.title, systemImage: tab.icon)
                    }
            }
        }
        .onAppear {
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
