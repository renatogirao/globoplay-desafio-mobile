//
//  Coordinator.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 29/01/25.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
