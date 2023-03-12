//
//  UIApplication.swift
//  iExchange
//
//  Created by Hala Mohammadi on 12/2/2023.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
