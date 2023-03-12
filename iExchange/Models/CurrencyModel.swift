//
//  CurrencyModel.swift
//  iExchange
//
//  Created by Hala Mohammadi on 12/2/2023.
//

import Foundation


// API URL: https://api.polygon.io/v2/aggs/grouped/locale/global/market/fx/2023-02-05?adjusted=true&apiKey=WvMhC3qMPpbuL2FNLgLpa38_aVyp7DAC

/*
 API Response:
 {
 "queryCount":1198,
 "resultsCount":1198,
 "adjusted":true,
 "results":[
 {"T":"C:NZDJPY","v":10009,"vw":83.288,"o":83.040105,"c":83.529,"h":83.953366,"l":82.511429,"t":1675641599999,"n":10009},
 {"T":"C:AUDNZD","v":10976,"vw":1.0935,"o":1.0926597,"c":1.0936201,"h":1.0994211,"l":1.08264,"t":1675641599999,"n":10976},
 {"T":"C:GBPARS","v":3667,"vw":226.0632,"o":225.9305,"c":226.5489,"h":226.95725,"l":225.9074,"t":1675641599999,"n":3667},
 {"T":"C:GBPILS","v":275,"vw":4.1156,"o":4.116561,"c":4.11499,"h":4.140533,"l":4.111945,"t":1675641599999,"n":275},
 {"T":"C:ZARJPY","v":5299,"vw":7.5346,"o":7.530081,"c":7.5471,"h":7.608829,"l":7.489,"t":1675641599999,"n":5299},
 {"T":"C:USDCHF","v":5463,"vw":0.926,"o":0.9262948,"c":0.92649,"h":0.92836,"l":0.9245255,"t":1675641599999,"n":5463},
 {"T":"C:AUDEUR","v":5820,"vw":0.6406,"o":0.6392227,"c":0.64119,"h":0.64194,"l":0.63406,"t":1675641599999,"n":5820},
 {"T":"C:AUDSGD","v":4502,"vw":0.9151,"o":0.9163224,"c":0.91678,"h":0.9192168,"l":0.9021331,"t":1675641599999,"n":4502},
 {"T":"C:CHFCAD","v":4644,"vw":1.4473,"o":1.4411076,"c":1.44633,"h":1.44889,"l":1.4411076,"t":1675641599999,"n":4644},
 {"T":"C:NZDCHF","v":5388,"vw":0.5855,"o":0.5859438,"c":0.58599,"h":0.58671,"l":0.58118,"t":1675641599999,"n":5388},
 {"T":"C:CADAUD","v":4758,"vw":1.0777,"o":1.0802183,"c":1.07827,"h":1.0822537,"l":1.0631884,"t":1675641599999,"n":4758},
 {"T":"C:GBPCAD","v":5521,"vw":1.6149,"o":1.6096123,"c":1.61398,"h":1.6229192,"l":1.60496,"t":1675641599999,"n":5521}
 ]}  ...
 */


struct CurrencyModel: Codable {
    let queryCount, resultsCount: Int
    let adjusted: Bool
    var results: [Result]
    let status, request_id: String
    let count: Int

}

struct Result: Codable, Hashable {
    let T: String
    let v: Int
    let vw: Double?
    let o, c, h: Double
    let l: Double
    let t: Int
    let n: Int
    
    var ticker1 : Substring {
        let start = T.index(T.startIndex, offsetBy: 2)
        let end = T.index(T.endIndex, offsetBy: -3)
        let range = start..<end
        return  T[range]
    }
    
    var ticker2 : Substring {
        let start = T.index(T.startIndex, offsetBy: 5)
        let range = start..<T.endIndex
        return  T[range]
    }
    
    var percentageChange: Double {
        let changeP = (o - c) / o
        return changeP
    }
    
}


//struct CurrencyModel: Codable {
//    let queryCount, resultsCount: Int
//    let adjusted: Bool
//    let results: [Result]
//    let status: String
//    let requestId: String
//    let count: Int
//
//    enum CodingKeys: String, CodingKey {
//        case queryCount, resultsCount, adjusted
//        case results
//        case status
//        case requestId = "request_id"
//        case count
//    }
//}
//
//struct Result: Hashable, Codable {
//    let ticker: String
//    let volume: Int
//    let vw: Double
//    let open: Double
//    let close, high, low: Double
//    let xTimeStamp: Int
//    let transactions: Int
//
//    enum AdditionalKeys: String, CodingKey {
//        case ticker = "T"
//        case volume = "v"
//        case vw
//        case open = "o"
//        case close = "c"
//        case high = "h"
//        case low = "l"
//        case xTimeStamp = "t"
//        case transactions = "n"
//
//    }
//}
