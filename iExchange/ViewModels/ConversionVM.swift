//
//  ConversionVM.swift
//  iExchange
//
//  Created by Hala Mohammadi on 24/2/2023.
//

import Foundation
import Combine

class ConversionVM: ObservableObject {
    
    @Published var corresponding : [String] = []
    @Published var currencies : [String] = []
    
    @Published var sourceText : String = ""
    @Published var destinationText : String = ""
    @Published var directOrSeq : Double = 0
    
    private var array : [String] = ["AUD", "NZD", "JPY", "GBP", "ARS", "ZAR", "USD", "CHF", "ILS", "EUR", "SGD", "PLN", "CAD", "CLP", "HKD", "KRW", "THB", "TRY", "BMD", "DKK", "CZK", "CNY", "XAG", "BGN", "NOK", "SEK", "KYD", "HUF", "XAU", "RON","AED", "INR", "CNH", "MXN", "NGN", "CYP", "PKR", "NIO", "MAD", "BWP", "JOD", "SAR", "ZMW", "TWD", "MYR", "EGP", "QAR","LKR", "LTL", "PEN", "PHP", "IDR", "TZS", "COP", "OMR", "VND", "KWD", "RUB", "XCD", "XPF", "DOP", "GTQ", "HTG", "HNL","CRC", "MUR", "UYU", "MVR", "TTD", "KZT", "FJD", "NPR", "RWF", "DZD", "KES", "AMD", "LSL", "BBD", "GHS", "UZS", "BDT","AFN", "GNF", "MMK", "CUP", "BRL", "BOB", "ISK", "SCR", "MWK", "KHR", "DJF", "MOP", "MGA", "LBP", "MKD", "ALL", "SLL","BHD", "PAB", "IQD", "SZL", "AWG", "ETB", "BND", "UGX", "BZD", "UAH", "BAM", "SVC", "TJS", "MDL", "BIF", "JMD", "PGK","LRD", "RSD", "BSD", "GYD", "LYD", "PYG", "SOS", "LAK", "TND", "SDG", "CDF", "MZN", "BTN", "NAD", "CVE"]
    
    private var sourceCorresp : [String: [String]] = ["JOD": ["AED", "ILS", "USD"], "HTG": ["GBP", "USD"], "ARS": ["CAD", "MXN", "JPY", "SGD", "CHF", "GBP", "HKD", "AUD", "USD", "ZAR", "EUR", "BRL", "CLP", "PEN", "COP"], "GYD": ["USD", "GBP"], "MGA": ["GBP", "USD"], "MKD": ["USD", "GBP"], "TJS": ["USD"], "BSD": ["USD", "GBP"], "DJF": ["GBP"], "DZD": ["USD", "EUR"], "USD": ["GBP", "PHP", "EUR", "NOK", "MXN", "HKD", "CHF", "ZAR", "CNH", "THB", "ARS", "HUF", "CAD", "CZK", "JPY", "AUD", "SEK", "PLN", "RON", "KRW", "TRY", "ISK", "BRL", "DKK", "NZD", "EGP", "SGD", "FJD", "RSD", "SAR", "INR", "IDR", "BHD", "DZD", "OMR", "BGN", "MUR", "KWD", "MYR", "SCR", "TWD", "CNY", "VND", "BAM", "DOP", "ETB", "RWF", "BBD", "PYG", "PKR", "UYU", "CVE", "KES", "BSD", "TTD", "LBP", "ALL", "MGA", "KYD", "BOB", "BND", "MMK", "LKR", "BDT", "ZMW", "PEN", "IQD", "GYD", "UZS", "KHR", "GNF", "CUP", "KZT", "MDL", "MKD", "TJS", "SZL", "GHS", "MOP", "MAD", "GTQ", "PAB", "CRC", "NIO", "HNL", "BWP", "MWK", "HTG", "UAH", "BZD", "JMD", "BIF", "LYD", "SVC", "DJF", "UGX", "PGK", "NPR", "LAK", "TZS", "RUB", "ILS", "JOD", "CLP", "COP", "NGN", "CDF", "SLL", "LSL", "XPF", "KMF", "NAD", "AWG", "GMD", "LRD", "YER", "TMT", "MVR", "QAR", "SDG", "SOS", "TND"], "CNY": ["CHF", "AUD", "HKD", "SGD", "ZAR", "INR", "NZD", "KRW", "CAD", "JPY", "EUR", "DKK", "BGN", "GBP", "USD", "CLP"], "TZS": ["ZAR", "USD"], "INR": ["CHF", "SEK", "HKD", "AUD", "ZAR", "KRW", "CAD", "JPY", "NZD", "SGD", "EUR", "THB", "GBP", "CNY", "USD", "MYR", "TWD", "PKR"], "BBD": ["GBP", "USD", "EUR"], "CDF": ["USD", "GBP"], "KHR": ["GBP"], "SGD": ["JPY", "AUD", "DKK", "EUR", "TRY", "HKD", "ZAR", "SEK", "ARS", "NOK", "CHF", "KRW", "PLN", "BRL", "INR", "GBP", "MXN", "TWD", "USD", "CAD", "NZD", "CNY", "THB", "AED", "MYR", "IDR", "PKR"], "KMF": ["GBP", "USD"], "XAU": ["HKD", "AUD", "RUB", "TRY", "GBP", "KRW", "USD", "JPY", "ARS", "EUR", "MXN", "CAD", "THB", "INR", "SAR", "BRL", "CNY", "ZAR"], "PAB": ["USD"], "MZN": ["USD"], "KZT": ["GBP", "USD"], "PKR": ["ZAR", "USD", "EUR", "JPY", "GBP"], "SLL": ["GBP", "USD"], "NZD": ["SEK", "SGD", "HKD", "JPY", "AUD", "CHF", "GBP", "NOK", "HUF", "EUR", "USD", "DKK", "PLN", "INR", "TRY", "CZK", "ZAR", "MXN", "KRW", "THB", "CAD", "CNY", "AED", "MYR", "TWD", "IDR", "PKR"], "HRK": ["AUD", "CAD"], "RUB": ["CHF", "NOK", "EUR", "PLN", "GBP", "JPY", "KRW", "SEK", "DKK", "USD"], "MAD": ["AUD", "USD", "ZAR", "GBP"], "HKD": ["AUD", "SGD", "PLN", "IDR", "MXN", "SEK", "ZAR", "EUR", "ARS", "CAD", "JPY", "USD", "CHF", "DKK", "INR", "GBP", "KRW", "NZD", "BRL", "THB", "CNY", "MYR", "TWD", "PKR"], "KWD": ["GBP", "EUR", "AED", "USD", "PKR"], "TMT": ["USD"], "FJD": ["GBP", "USD"], "MXN": ["CAD", "HKD", "PLN", "AUD", "ARS", "ZAR", "SGD", "BRL", "CZK", "CHF", "JPY", "DKK", "EUR", "GBP", "USD", "CLP", "COP", "PEN"], "BHD": ["USD", "EUR", "PKR"], "TRY": ["SGD", "DKK", "USD", "ZAR", "CHF", "JPY", "PLN"], "RSD": ["USD", "GBP"], "PLN": ["HUF", "SEK", "EUR", "CZK", "USD", "CHF", "MXN", "NOK", "JPY", "GBP", "DKK", "ILS"], "MUR": ["GBP", "EUR", "USD"], "SOS": ["GBP", "USD"], "TWD": ["HKD", "AUD", "SGD", "CHF", "SEK", "NZD", "JPY", "CAD", "KRW", "ZAR", "CNY", "INR", "THB", "MYR", "DKK", "USD", "EUR", "IDR", "PKR"], "BND": ["USD", "GBP"], "LKR": ["ZAR", "GBP", "USD"], "LBP": ["USD"], "SHP": ["USD"], "SVC": ["GBP", "USD"], "AFN": ["GBP"], "AWG": ["GBP", "USD"], "UYU": ["EUR", "GBP", "USD"], "BAM": ["GBP", "USD"], "OMR": ["ZAR", "GBP", "USD", "AED", "PKR"], "MMK": ["GBP", "USD"], "GBP": ["JPY", "MXN", "NIO", "NOK", "ZAR", "IDR", "CHF", "HUF", "NZD", "CAD", "EUR", "ARS", "SGD", "VND", "SEK", "CZK", "PLN", "PHP", "CNH", "HKD", "TRY", "DKK", "USD", "ILS", "AUD", "KRW", "THB", "CRC", "NGN", "EGP", "XCD", "ISK", "BMD", "HTG", "GTQ", "PEN", "XPF", "CLP", "HNL", "BRL", "DOP", "FJD", "RON", "INR", "SAR", "MUR", "BGN", "BHD", "RSD", "OMR", "CNY", "DZD", "KWD", "MYR", "SCR", "TWD", "RUB", "LSL", "BND", "MDL", "PAB", "AED", "GYD", "LKR", "PGK", "KES", "LRD", "KZT", "SVC", "BSD", "MAD", "DJF", "BDT", "MWK", "MKD", "TND", "BBD", "BIF", "LBP", "COP", "SZL", "BZD", "LAK", "BOB", "UAH", "IQD", "AFN", "UYU", "MGA", "PYG", "CUP", "BWP", "ETB", "CDF", "KHR", "JMD", "AMD", "UGX", "NPR", "GHS", "MOP", "BAM", "TTD", "LYD", "MMK", "JOD", "GNF", "KYD", "BTN", "RWF", "SOS", "ALL", "SLL", "AWG", "KMF", "QAR", "YER", "PKR", "MVR"], "THB": ["HKD", "SGD", "IDR", "CHF", "AUD", "KRW", "JPY", "USD", "NZD", "ZAR", "CAD", "GBP", "INR", "EUR", "CNY", "MYR", "TWD", "PKR"], "BIF": ["USD"], "SEK": ["CZK", "USD", "NOK", "AUD", "EUR", "PLN", "CAD", "ZAR", "GBP", "DKK", "ILS", "JPY", "CHF", "INR", "RUB"], "CYP": ["ZAR"], "DOP": ["GBP", "USD"], "UGX": ["ZAR"], "LYD": ["USD", "GBP"], "TND": ["GBP", "ZAR", "USD"], "EGP": ["ZAR", "JPY", "USD", "EUR", "PKR"], "NGN": ["GBP", "ZAR", "JPY", "USD"], "QAR": ["ZAR", "AED", "GBP", "PKR", "USD"], "PYG": ["USD"], "JPY": ["AUD", "CHF", "NZD", "EUR", "NOK", "SEK", "HKD", "IDR", "DKK", "GBP", "ARS", "CAD", "ILS", "MXN", "USD", "BRL", "KRW", "INR", "THB", "PLN", "ZAR", "CZK", "RSD", "SAR", "CNY", "MYR", "TWD", "RUB", "CLP", "AED", "PKR"], "RWF": ["GBP", "USD", "ZAR"], "UZS": ["USD"], "BZD": ["USD"], "CHF": ["RUB", "HKD", "DKK", "SGD", "SEK", "CAD", "ARS", "NOK", "EUR", "NZD", "JPY", "IDR", "ZAR", "HUF", "AUD", "CLP", "USD", "PLN", "PKR", "INR", "CZK", "THB", "RON", "BRL", "KRW", "ILS", "TRY", "MXN", "GBP", "CNY", "RSD", "MYR", "TWD", "AED", "SZL", "BWP"], "BGN": ["CAD", "AUD", "CNY", "DKK", "USD"], "JMD": ["GBP", "USD"], "LTL": ["AUD"], "HNL": ["GBP", "USD"], "PEN": ["CAD", "MXN", "GBP", "ARS", "BRL", "USD", "COP", "CLP", "EUR"], "BDT": ["USD", "JPY", "GBP"], "HUF": ["CHF", "PLN", "DKK", "CAD", "EUR", "JPY", "USD", "ZAR"], "DKK": ["AUD", "HUF", "THB", "GBP", "RUB", "HKD", "CAD", "PHP", "EUR", "JPY", "PKR", "MXN", "TRY", "ZAR", "NZD", "PLN", "SEK", "CHF", "NOK", "SGD", "CZK", "USD", "BGN", "INR", "AED", "CNY", "MYR", "TWD", "COP", "UAH", "ISK"], "AUD": ["CNH", "BGN", "CHF", "USD", "ZAR", "TRY", "GBP", "HUF", "JPY", "CLP", "ARS", "NOK", "CAD", "SGD", "SEK", "LTL", "MXN", "DKK", "PLN", "HRK", "IDR", "HKD", "PHP", "EUR", "NZD", "MAD", "ILS", "INR", "KRW", "CZK", "BRL", "THB", "FJD", "AED", "CNY", "MYR", "TWD", "PGK", "PKR"], "XAG": ["SAR", "GBP", "INR", "HKD", "ARS", "CAD", "CNY", "AUD", "RUB", "TRY", "MXN", "BRL", "JPY", "USD", "EUR", "KRW", "ZAR"], "ISK": ["USD", "CHF"], "YER": ["GBP", "USD"], "NOK": ["GBP", "CHF", "JPY", "ZAR", "SEK", "ILS", "USD", "EUR", "DKK", "PLN", "INR", "AED", "RUB"], "PHP": ["DKK", "GBP", "USD", "JPY"], "SZL": ["USD", "ZAR", "CHF", "GBP", "EUR"], "IDR": ["HKD", "GBP", "AUD", "EUR", "JPY", "KRW", "CAD", "SGD", "CHF", "ZAR", "NZD", "CNY", "INR", "THB", "MYR", "TWD", "USD"], "MWK": ["USD", "GBP", "ZAR"], "SCR": ["GBP", "USD"], "ZMW": ["ZAR", "USD"], "CZK": ["CAD", "PLN", "SEK", "MXN", "ZAR", "CHF", "EUR", "USD", "NOK", "DKK", "JPY"], "NIO": ["GBP", "USD"], "CLP": ["CHF", "AUD", "GBP", "EUR", "ARS", "MXN", "CNY", "BRL", "USD", "COP", "PEN"], "ZAR": ["SEK", "MXN", "CHF", "HKD", "NOK", "PLN", "AUD", "JPY", "SGD", "DKK", "RON", "USD", "AED", "EGP", "CAD", "NGN", "GBP", "TRY", "ARS", "PKR", "NZD", "PHP", "THB", "ILS", "HUF", "BWP", "CZK", "KRW", "EUR", "BRL", "CYP", "CNY", "INR", "MYR", "TWD", "IDR", "KES", "UGX", "COP", "MAD", "SZL", "MWK", "GHS", "RWF", "NAD", "TND"], "BTN": ["GBP"], "UAH": ["DKK", "USD"], "BWP": ["ZAR", "USD", "GBP", "CHF", "EUR"], "LSL": ["GBP", "USD"], "BOB": ["USD", "GBP"], "AMD": ["GBP"], "TTD": ["USD", "GBP"], "CNH": ["USD", "JPY", "HKD"], "PGK": ["GBP", "USD", "AUD"], "MDL": ["EUR", "GBP", "USD"], "COP": ["BRL", "MXN", "USD", "ARS", "CAD", "DKK", "ZAR", "CLP"], "BMD": ["CAD", "GBP", "BBD", "KYD", "EUR"], "MYR": ["CHF", "AUD", "SGD", "HKD", "JPY", "KRW", "ZAR", "NZD", "INR", "CAD", "THB", "CNY", "USD", "DKK", "GBP", "TWD", "IDR", "EUR", "PKR"], "AED": ["ZAR", "DKK", "BHD", "EUR", "SEK", "SAR", "NOK", "INR", "GBP", "NZD", "AUD", "CHF", "JPY", "CAD", "USD", "PKR"], "CAD": ["USD", "DKK", "AUD", "AED", "ARS", "CZK", "SGD", "BGN", "VND", "EUR", "JPY", "BMD", "ZAR", "SEK", "NOK", "KYD", "HRK", "HUF", "GBP", "CHF", "IDR", "HKD", "TRY", "THB", "BRL", "ILS", "MXN", "INR", "RUB", "KRW", "NZD", "KWD", "PLN", "CNY", "SAR", "MYR", "TWD", "COP", "PEN", "PKR"], "KES": ["USD", "ZAR"], "ETB": ["USD", "GBP"], "XPF": ["GBP", "USD"], "KYD": ["CAD", "USD", "BMD", "GBP", "EUR"], "LRD": ["GBP", "USD"], "GTQ": ["GBP", "USD"], "NPR": ["USD", "GBP"], "GNF": ["GBP", "USD"], "IQD": ["USD", "GBP"], "CRC": ["GBP", "USD"], "SAR": ["KWD", "JPY", "EUR", "USD", "PKR"], "ALL": ["USD", "GBP", "EUR"], "GHS": ["USD", "ZAR", "GBP", "EUR"], "BRL": ["COP", "AUD", "ARS", "MXN", "JPY", "CHF", "PEN", "CAD", "HKD", "CLP", "EUR", "SGD", "SEK", "ZAR", "USD", "KRW", "RSD"], "MVR": ["USD"], "CUP": ["USD"], "RON": ["CHF", "ZAR", "USD", "GBP"], "XCD": ["GBP"], "KRW": ["SGD", "SEK", "AUD", "HKD", "ZAR", "EUR", "INR", "USD", "CAD", "CHF", "BRL", "NZD", "JPY", "THB", "CNY", "MYR", "TWD", "IDR", "RUB"], "ILS": ["SEK", "ZAR", "AUD", "NOK", "CHF", "JPY", "CAD", "EUR", "USD", "JOD", "AED", "PLN"], "MOP": ["USD"], "VND": ["JPY", "EUR", "CAD", "USD"], "EUR": ["AUD", "SGD", "NZD", "CAD", "CHF", "USD", "SEK", "HKD", "JPY", "CNH", "PLN", "NOK", "HUF", "DKK", "ZAR", "MXN", "GBP", "ARS", "TRY", "BRL", "CZK", "RUB", "EGP", "INR", "FJD", "KRW", "CNY", "JOD", "SAR", "AED", "BHD", "KWD", "DZD", "RSD", "PHP", "BGN", "MUR", "OMR", "THB", "TWD", "PKR", "IDR", "LBP", "ILS", "RON", "SLL", "KES", "MWK", "MMK", "IQD", "MYR", "NIO", "SVC", "UZS", "LYD", "CLP", "LSL", "BWP", "KYD", "MOP", "HNL", "BZD", "QAR", "ALL", "SZL", "HTG", "BSD", "JMD", "MGA", "NAD", "TJS", "BOB", "MDL", "RWF", "BBD", "ETB", "PEN", "CUP", "ZMW", "GTQ", "PYG", "KHR", "BIF", "LAK", "AMD", "NPR", "SOS", "TND", "UGX", "LRD", "ISK", "CRC", "COP", "DOP", "LKR", "UAH", "UYU", "GYD", "AFN", "CDF", "VND", "BTN", "BDT", "KZT", "PAB", "GNF", "NGN", "BMD", "TZS", "PGK", "BND", "MKD", "GHS", "TTD", "DJF", "MAD", "MVR", "MZN", "SDG", "YER"]]

    @Published var shortestPath : [Substring] = []
    @Published var vertices : [Substring] = []
    @Published var edges : [ProcessedDataModel] = []
    @Published var arbDict : [String: [String: Double]] = [:]
    
    private var dataService = CurrencyDataService()
    private var cancellables = Set<AnyCancellable>()
    
    
    init() {
        getData()
    }
    
    func updateSource(text: String) {
        sourceText = text
        updateDestination(text: "")
        currencies = array
    }
    
    func updateDestination(text: String) {
        destinationText = text
        currencies = array
        subscribe()
    }
    
    func getData() {
        
        $sourceText
            .map { (text: String) -> [String] in
                let upper = text.uppercased()
                guard !text.isEmpty else {
                    return self.array
                }
                let filtered = self.array.filter { currency in
                    return currency.contains(upper)
                }
                return filtered
            }
            .sink { [weak self] returnedCurrencies in
                self?.currencies = returnedCurrencies
            }
            .store(in: &cancellables)
        
        
        $destinationText
            .combineLatest($sourceText)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map { (dest: String, source: String) -> [String] in
                let upper = dest.uppercased()
                guard !source.isEmpty else {
                    return []
                }
                let array : [String] = self.sourceCorresp[source] ?? []
                guard !dest.isEmpty else {
                    return array
                }

                let filtered = array.filter { currency in
                    return currency.contains(upper)
                }
                return filtered
            }
            .sink { [weak self] returnedCurrencies in
                self?.corresponding = returnedCurrencies
            }
            .store(in: &cancellables)
    }
    
    func subscribe() {
        
        dataService.$results
            .map { (element) -> ([ProcessedDataModel], [String: [String: Double]]) in
                var rates : [ProcessedDataModel] = []
                var dict :  [String: [String: Double]] = [:]
                for currency in element {
                    let loggedRate : Double = log(currency.c)
                    // populate edges
                    let data : ProcessedDataModel = ProcessedDataModel(source: currency.ticker1, destination: currency.ticker2, rate: loggedRate)
                    rates.append(data)
                    // populate arbDict
                    if (dict[String(currency.ticker1)] != nil) {
                        dict[String(currency.ticker1)]?[String(currency.ticker2)] = loggedRate
                    } else {
                        dict[String(currency.ticker1)] = [String(currency.ticker2) : loggedRate]
                    }
                }
                return (rates, dict)
            }
            .sink { (processedEdges, processedDict) in
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
            .combineLatest($edges, $sourceText, $destinationText)
            .debounce(for: .seconds(0.2), scheduler: DispatchQueue.main)
            .map { (vertices: [Substring], edges: [ProcessedDataModel], text: String, text2: String) -> ([Substring], Double) in
                
                let verticesCount = vertices.count
                var distanceDict = Dictionary<Substring,Double>()
                var predecessorDict = Dictionary<String,String>()
                var seen = Dictionary<Substring,Bool>()
                
                let source: Substring = Substring(text)
                var destination: Substring = Substring(text2)
                
                for vertex in vertices {
                    distanceDict[vertex] = Double.infinity
                    predecessorDict[String(vertex)] = "-1"
                    seen[vertex] = false
                }
                distanceDict.updateValue(0, forKey: source)
                for _ in 1..<verticesCount {
                    for edge in edges {
                        guard let u = distanceDict[edge.source],
                              let v = distanceDict[edge.destination] else {return ([], 0)}
                        let weight = u + edge.rate
                        if (weight < v) {
                            distanceDict.updateValue(weight, forKey: edge.destination)
                            predecessorDict.updateValue(String(edge.source), forKey: String(edge.destination))
                        }
                    }
                }
                var shortest :  [Substring] = []
                var pathExch : Double = 0.0
                var direct : Double = 0.0
                var cycle : Bool = false
                while destination != source && destination != "-1" {
                    if shortest.contains(destination) {
                        cycle = true
                        break;
                    }
                    shortest.append(destination)
                    let parent = predecessorDict[String(destination)] ?? ""
                    pathExch += self.arbDict[parent]?[String(destination)] ?? 0
                    destination = Substring(parent)
                }
                
                shortest.append(destination)
                shortest = shortest.reversed()

                pathExch = exp(pathExch)
                direct = self.arbDict[text]?[text2] ?? 0
                direct = exp(direct)
                print(shortest)
                if (cycle) {
                    print("direct ==> \(direct.show4decimals())")
                    print([Substring(text), Substring(text2)])
                    return ([Substring(text), Substring(text2)], direct)
                }
                print("direct ==> \(direct.show4decimals())")
                print("cheapeast ==> \(pathExch.show4decimals())")
                print(shortest)
                return (shortest, pathExch)
            }
            .sink { (sequence, amount) in
                self.shortestPath = sequence
                self.directOrSeq = amount
            }
            .store(in: &cancellables)
    }
}
