//
//  SceneDelegate.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 30/01/25.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
        
        appCoordinator = AppCoordinator(window: window!)
        appCoordinator?.start()
        
        window?.makeKeyAndVisible()
    }
}
