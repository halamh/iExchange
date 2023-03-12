//
//  CurrencyViewModel.swift
//  iExchange
//
//  Created by Hala Mohammadi on 12/2/2023.
//

import Foundation
import Combine


class CurrencyViewModel: ObservableObject {
    
    @Published var results : [Result] = DeveloperPreview.instance.pair.results
    
    @Published var seachables : [Result] = DeveloperPreview.instance.pair.results
    @Published var searchText: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    private var dataService = CurrencyDataService()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        
        dataService.$results
            .sink(receiveValue: { [weak self] (returnedCurrencies) in
                self?.seachables = returnedCurrencies
            })
            .store(in: &cancellables)
        
        $searchText
            .combineLatest($seachables)
            .map({ (text, currencies: [Result]) -> [Result] in
                guard !text.isEmpty else {
                    return currencies
                }
                let upper = text.uppercased()
                return currencies.filter { (element) -> Bool in
                    return element.T.contains(upper)
                }
            })
            .sink { [weak self] (returnedResults) in
                self?.results = returnedResults
            }
            .store(in: &cancellables)
        
    }
}
