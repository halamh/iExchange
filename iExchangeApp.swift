//
//  iExchangeApp.swift
//  iExchange
//
//  Created by Hala Mohammadi on 12/2/2023.
//

import SwiftUI

@main
struct iExchangeApp: App {
    @StateObject private var vm = CurrencyViewModel()
    @StateObject private var vmArb = ArbVM()
    @StateObject private var convertVM = ConversionVM()
    var body: some Scene {
        WindowGroup {
//            NavigationView {
                HomeView(searchText: .constant(""))
                    .environmentObject(vm)
                    .environmentObject(vmArb)
                    .environmentObject(convertVM)
                    .navigationBarHidden(true)
//            }
//            .navigationBarHidden(true)
        }
    }
}
