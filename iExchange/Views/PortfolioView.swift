//
//  PortfolioView.swift
//  iExchange
//
//  Created by Hala Mohammadi on 16/2/2023.
//

import SwiftUI

struct PortfolioView: View {
    @State private var searchText : String = ""
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        NavigationView {
            ZStack {
                Color.theme.background
                    .ignoresSafeArea()
                VStack {
                    
                    homeHeader
                    Divider()
                    HStack {
                        Text("Portfolio")
                            .font(.headline)
                            .bold()
                    }
                    .padding(.top)
                    searchBar
                    Spacer(minLength: 0)
                    
                    List {
                        
                    }
                    .listStyle(PlainListStyle())
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .preferredColorScheme(.dark)
    }
}


extension PortfolioView {
    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Search by name or ticker...", text: $searchText)
                .disableAutocorrection(true)
            Spacer()
            Image(systemName: "xmark")
                .opacity(searchText.isEmpty ? 0.0 : 1.0)
                .onTapGesture {
                    UIApplication.shared.endEditing()
                    searchText = ""
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
    
    private var homeHeader : some View {
        HStack {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                VStack {
                    CircleButtonView(name: "chevron.left", opacity: colorScheme == .dark ? 0.3 : 0.4)
                    Text("")
                }
            })
            Spacer()
            VStack {
                CircleButtonView(name: "briefcase", opacity: colorScheme == .dark ? 0.8 : 0.6)
                Text("Portfolio")
                    .font(.headline)
            }
        }
        .padding()
    }
}
