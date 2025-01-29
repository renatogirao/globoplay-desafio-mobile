//
//  UIColor+hex.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 29/01/25.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        var hexInt = UInt64()
        Scanner(string: hex).scanHexInt64(&hexInt)
        
        self.init(
            .sRGB,
            red: Double((hexInt & 0xFF0000) >> 16) / 255.0,
            green: Double((hexInt & 0x00FF00) >> 8) / 255.0,
            blue: Double(hexInt & 0x0000FF) / 255.0,
            opacity: 1.0
        )
    }
}
