//
//  HomeView.swift
//  iExchange
//
//  Created by Hala Mohammadi on 12/2/2023.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var vm : CurrencyViewModel
    @Binding var searchText : String
    
    @State var goPortfolio : Bool = false
    @State var goConvert : Bool = false
    @State var goArbitrage : Bool = false
    
    var body: some View {
        NavigationView {
    
            ZStack {
                Color.theme.background
                    .ignoresSafeArea()
                VStack {
                
                    homeHeader
                    Divider()
                    HStack {
                        Text("Live Prices")
                            .font(.headline)
                            .bold()
                        Image(systemName: "chart.line.uptrend.xyaxis")
                    }
                    .padding(.top)
                    searchBar
                    Spacer(minLength: 0)
                    
                    List {
                        ForEach(vm.results, id: \.self) { ele in
                            CurrencyRowView(currency: ele)
                                .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                                .listRowBackground(Color.theme.background)
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationBarHidden(true)
        }
        .navigationBarHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(searchText: .constant(""))
            .preferredColorScheme(.dark)
            .environmentObject(CurrencyViewModel())
    }
}

extension HomeView {
    private var homeHeader : some View {
        HStack {
            VStack {
                NavigationLink {
                    ArbView()
                } label: {
                    VStack {
                        CircleButtonView(name: "arrow.triangle.2.circlepath", opacity: 0.25)
                        Text("Arbitrage")
                            .font(.headline)
                    }
                }
            }
            Spacer()
            VStack {
                NavigationLink {
                    ConvertView()
                } label: {
                    VStack {
                        CircleButtonView(name: "arrow.left.arrow.right",opacity: 0.25)
                        Text("Convert")
                            .font(.headline)
                    }
                }
            }
            Spacer()
            VStack {
                NavigationLink {
                    PortfolioView()
                } label: {
                    VStack {
                        CircleButtonView(name: "briefcase", opacity: 0.25)
                        Text("Portfolio")
                            .font(.headline)
                    }
                }
            }
        }
        .padding()
    }
    
    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Search by name or ticker...", text: $vm.searchText)
                .disableAutocorrection(true)
            Spacer()
            Image(systemName: "xmark")
                .opacity(vm.searchText.isEmpty ? 0.0 : 1.0)
                .onTapGesture {
                    UIApplication.shared.endEditing()
                    vm.searchText = ""
                }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 50)
                .foregroundColor(Color.theme.background)
                .shadow(color: Color.theme.accent.opacity(0.3), radius: 5, x: 0, y: 0)
        )
        .padding()
    }
}
