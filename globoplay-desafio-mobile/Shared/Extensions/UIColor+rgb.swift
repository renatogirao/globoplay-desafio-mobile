//
//  UIColor+rgb.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 29/01/25.
//

import SwiftUI

extension Color {
    static func rgb(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> Color {
        return Color(red: r / 255.0, green: g / 255.0, blue: b / 255.0)
    }
}
