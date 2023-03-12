//
//  Double.swift
//  iExchange
//
//  Created by Hala Mohammadi on 14/2/2023.
//

import Foundation

extension Double {
    func asNumberString() -> String {
        ///```
        ///converts 1.234500 to "1.2345"
        ///```
        return String(format: "%.4f", self)
    }
    
    func show4decimals() -> String {
        return (floor(self * 10000) / 10000).asNumberString()
    }
    
}
