//
//  MainTabView.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 28/01/25.
//

import SwiftUI

struct MainTabView: View {
    @ObservedObject var tabBarManager = TabBarManager()

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
        .accentColor(.textColor)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
