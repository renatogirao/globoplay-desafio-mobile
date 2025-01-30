//
//  globoplay_desafio_mobileApp.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 28/01/25.
//

import SwiftUI

@main
struct globoplay_desafio_mobileApp: App {
    @StateObject private var coordinator = AppCoordinator(window: UIWindow())

    let persistenceController = PersistenceController.shared

    init() {
        configureKeychain()
        UINavigationBar.appearance().backgroundColor = UIColor(Color.navigationBarBackground)
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor(Color.textColor)
        ]
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: UIColor(Color.textColor)
        ]
    }

    var body: some Scene {
        WindowGroup {
            MainTabView(coordinator: coordinator)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }

    private func configureKeychain() {
        let keychainManager = KeychainManager()
        keychainManager.saveAPIKey(apiKey: "d830c306bbead007f72d9ad843bc6985")
        keychainManager.saveToken(token: "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkODMwYzMwNmJiZWFkMDA3ZjcyZDlhZDg0M2JjNjk4NSIsIm5iZiI6MTY3MDg4MDg2MS42MTYsInN1YiI6IjYzOTc5ZTVkNzliM2Q0MDA4YWRjNzBlNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.K4CkRCoO1rBwDfJrHszE1wFD-BQC2G6UUTTjqLzAle0")
    }
}
