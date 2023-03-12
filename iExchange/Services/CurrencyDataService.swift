//
//  CurrencyDataService.swift
//  iExchange
//
//  Created by Hala Mohammadi on 12/2/2023.
//

import Foundation
import Combine

class CurrencyDataService {
//    @Published var pairs : CurrencyModel = DeveloperPreview.instance.pair
    @Published var results : [Result] = DeveloperPreview.instance.pair.results
    var cancellables = Set<AnyCancellable>()
    
    let url : String = "https://api.polygon.io/v2/aggs/grouped/locale/global/market/fx/2023-02-10?adjusted=true&apiKey=WvMhC3qMPpbuL2FNLgLpa38_aVyp7DAC"
    
    init() {
        getCurrencies()
    }
    
    func getCurrencies() {
        
        guard let url = URL(string: url) else {
            return
        }
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ (output) -> Data in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            })
            .receive(on: DispatchQueue.main)
            .decode(type: CurrencyModel.self, decoder: JSONDecoder())
            .sink { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] (returnedCurrencies) in
//                self?.pairs = returnedCurrencies
                self?.results = returnedCurrencies.results
            }
            .store(in: &cancellables)
            
    }
}
