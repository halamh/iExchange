//
//  CurrencyPickVM.swift
//  iExchange
//
//  Created by Hala Mohammadi on 17/2/2023.
//

import Foundation
import Combine

class ArbVM: ObservableObject {
    
    @Published var currencies : [String] = []
    var array : [String] = ["AUD", "NZD", "JPY", "GBP", "ARS", "ZAR", "USD", "CHF", "ILS", "EUR", "SGD", "PLN", "CAD", "CLP", "HKD", "KRW", "THB", "TRY", "BMD", "DKK", "CZK", "CNY", "XAG", "BGN", "NOK", "SEK", "KYD", "HUF", "XAU", "RON", "AED", "INR", "CNH", "MXN", "NGN", "CYP", "PKR", "NIO", "MAD", "BWP", "JOD", "SAR", "ZMW", "TWD", "MYR", "EGP", "QAR", "LKR", "LTL", "PEN", "PHP", "IDR", "TZS", "COP", "OMR", "VND", "KWD", "RUB", "XCD", "XPF", "DOP", "GTQ", "HTG", "HNL", "CRC", "MUR", "UYU", "MVR", "TTD", "KZT", "FJD", "NPR", "RWF", "DZD", "KES", "AMD", "LSL", "BBD", "GHS", "UZS", "BDT", "AFN", "GNF", "MMK", "CUP", "BRL", "BOB", "ISK", "SCR", "MWK", "KHR", "DJF", "MOP", "MGA", "LBP", "MKD", "ALL", "SLL", "BHD", "PAB", "IQD", "SZL", "AWG", "ETB", "BND", "UGX", "BZD", "UAH", "BAM", "SVC", "TJS", "MDL", "BIF", "JMD", "PGK", "LRD", "RSD", "BSD", "GYD", "LYD", "PYG", "SOS", "LAK", "TND", "SDG", "CDF", "MZN", "BTN", "NAD", "CVE"]
    
    var cancellables = Set<AnyCancellable>()
    @Published var arbText : String = ""
    
    @Published var calculation :  [Double] = []
    @Published var pairs :  [[Double]] = [[]]
    
    @Published var arbitrage :  Set<[Substring]> = [[]]
    @Published var vertices : [Substring] = []
    @Published var edges : [ProcessedDataModel] = []
    @Published var arbDict : [Substring: [Substring: Double]] = [:]
    @Published var results : [Result] = DeveloperPreview.instance.pair.results
    private var dataService = CurrencyDataService()
    
    init() {
        getData()
    }
    
    func updateArb(text: String) {
        arbText = text
        subscribe() 
        currencies = array
    }
    
    
    func getData() {
        $arbText
            .map { (text: String) -> [String] in
                let lower = text.uppercased()
                guard !text.isEmpty else {
                    return self.array
                }
                let filtered = self.array.filter { currency in
                    return currency.contains(lower)
                }
                return filtered
            }
            .sink { [weak self] returnedCurrencies in
                self?.currencies = returnedCurrencies
            }
            .store(in: &cancellables)
    }
    
    func subscribe() {
        
        dataService.$results
            .map { (element) -> ([ProcessedDataModel], [Substring: [Substring: Double]]) in
                print(element)
                var rates : [ProcessedDataModel] = []
                var dict :  [Substring: [Substring: Double]] = [:]
                for currency in element {
                    let loggedRate : Double = -log(currency.c)
//                    let loggedRate = Double(round(10000 * rate) / 10000)
                    // populate edges
                    let data : ProcessedDataModel = ProcessedDataModel(source: currency.ticker1, destination: currency.ticker2, rate: loggedRate)
                    rates.append(data)
                    // populate arbDict
                    if (dict[currency.ticker1] != nil) {
                        dict[currency.ticker1]?[currency.ticker2] = loggedRate
                    } else {
                        dict[currency.ticker1] = [currency.ticker2 : loggedRate]
                    }
                }
                return (rates, dict)
            }
            .sink { (processedEdges, processedDict) in
                print(processedEdges)
                self.edges = processedEdges
                self.arbDict = processedDict
            }
            .store(in: &cancellables)
        
        dataService.$results
            .map { (element) -> [Substring] in
                var vertexList : [Substring] = []
                for currency in element {
                    if !vertexList.contains(currency.ticker1) {
                        vertexList.append(currency.ticker1)
                    }
                    if !vertexList.contains(currency.ticker2) {
                        vertexList.append(currency.ticker2)
                    }
                }
                return vertexList
            }
            .sink { [weak self] (receivedValue) in
                self?.vertices = receivedValue
            }
            .store(in: &cancellables)
        
        
        $vertices
            .combineLatest($edges, $arbText)
            .map { (vertices: [Substring], edges: [ProcessedDataModel], text: String) ->  Set<[Substring]> in
                
                let verticesCount = vertices.count
                var distanceDict = Dictionary<Substring,Double>()
                var predecessorDict = Dictionary<Substring,Substring>()
                var seen = Dictionary<Substring,Bool>()
                let source = Substring(text)
                for vertex in vertices {
                    distanceDict[vertex] = Double.infinity
                    predecessorDict[vertex] = "-1"
                    seen[vertex] = false
                }
                distanceDict.updateValue(0, forKey: source) // this will be connect later with the arb text
                for _ in 1..<verticesCount {
                    for edge in edges {
                        guard let u = distanceDict[edge.source],
                              let v = distanceDict[edge.destination] else {return [[]]}
                        let weight = u + edge.rate
//                        let logW = Double(round(10000 * weight) / 10000)
                        if (weight < v) {
                            distanceDict.updateValue(weight, forKey: edge.destination)
                            predecessorDict.updateValue(edge.source, forKey: edge.destination)
                        }
                    }
                }
                var allCycles :  Set<[Substring]> = []
                for edge in edges {
//                    if seen[edge.destination] == true {
//                        continue
//                    }
                    guard let u = distanceDict[edge.source],
                          let v = distanceDict[edge.destination] else {return [[]]}
                    let weight = u + edge.rate
                    if (weight < v) {
                        var cycle : [Substring] = []
                        var cycleVertex : Substring = edge.destination
                        while true {
                            seen[cycleVertex] = true
                            cycle.append(cycleVertex)
                            guard let parent = predecessorDict[cycleVertex] else {break}
                            cycleVertex = parent
                            if cycleVertex == edge.destination || cycle.contains(cycleVertex) {
                                break
                            }
                        }
//                        if (cycleVertex != source) {
//                            continue
//                        }
                        guard let index = cycle.firstIndex(of: cycleVertex) else {break}
                        cycle.append(cycleVertex)
                        var sliced : [Substring] = []
                        for (i, element) in cycle.enumerated() {
                            if i >= index {
                                sliced.append(element)
                            }
                        }
                        sliced = Array(sliced.reversed())
                        allCycles.insert(sliced)
                    }
                }
                print(allCycles)
                return allCycles
            }
            .sink { received in
                self.arbitrage = received
            }
            .store(in: &cancellables)
     
        $arbitrage
            .combineLatest($arbDict)
            .map { (arbs, arbDict) -> (calculation: [Double], pairs: [[Double]]) in
                var calc : [Double] = []
                var pairsExc : [[Double]] = []
                for arb in arbs {
                    let count = arb.count
                    var total : Double = 1.0
                    var pair : [Double] = [1.0]
                    for index in 1..<count {
                        let p = arbDict[arb[index-1]]?[arb[index]]
                        let expP = exp(-(p ?? 0))
//                        let rounded = Double(round(10000 * expP) / 10000)
                        pair.append(expP)
                        total *= expP
                    }
                    pairsExc.append(pair)
                    calc.append(total)
                }
                return (calc, pairsExc)
            }
            .sink { (rcevivedCalc, receivedPairs) in
                print(receivedPairs)
                print(rcevivedCalc)
                self.pairs = receivedPairs
                self.calculation = rcevivedCalc
            }
            .store(in: &cancellables)
    }
}
