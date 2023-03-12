//
//  Color.swift
//  iExchange
//
//  Created by Hala Mohammadi on 12/2/2023.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let red = Color("RedColor")
    let green = Color("GreenColor")
    let secondaryText = Color("SecondaryTextColor")
    let background = Color("BackgroundColor")
}
