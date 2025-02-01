//
//  URL+IsValid.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 01/02/25.
//

import Foundation
import UIKit

extension URL {
    var isValidURL: Bool {
        return UIApplication.shared.canOpenURL(self)
    }
}
