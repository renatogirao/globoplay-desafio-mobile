//
//  FavoritesViewControllerRepresentable.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 31/01/25.
//

import SwiftUI

struct FavoritesViewControllerRepresentable: UIViewControllerRepresentable {
    var viewController: FavoritesViewController
    
    func makeUIViewController(context: Context) -> FavoritesViewController {
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: FavoritesViewController, context: Context) {
        // Apenas caso precise fa zer masi alteracoes
    }
}

