//
//  DeveloperPreview.swift
//  iExchange
//
//  Created by Hala Mohammadi on 13/2/2023.
//

import Foundation
import SwiftUI

class DeveloperPreview {
    static let instance = DeveloperPreview()
    private init() {}
    
    let pair = CurrencyModel(queryCount: 1, resultsCount: 2, adjusted: true, results: [

        Result(T: "C:NZDJPY", v: 10976, vw: 1.0935, o: 83.040105, c: 83.529, h: 83.953366, l: 82.511429, t: 1675641599999, n: 10976)
    ], status: "OK", request_id: "88798669b357caadcadc059e27e0092b", count: 1198)
    
}
