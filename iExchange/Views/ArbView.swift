//
//  ArbView.swift
//  iExchange
//
//  Created by Hala Mohammadi on 16/2/2023.
//

import SwiftUI

struct ArbView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var arbVM : ArbVM
    @State var pickArbSource : Bool = false
    @State var showArbList : Bool = false
    
    var body: some View {
        ZStack {
            NavigationView {
                ZStack {
                    Color.theme.background
                        .ignoresSafeArea()
                        .sheet(isPresented: $pickArbSource, content: {PickCurrency(sourceOrDest: .arb)})
                    
                    VStack {
                        
                        homeHeader
                        Divider()
                        HStack {
                            Text("Arbitrage")
                                .font(.headline)
                                .bold()
                        }
                        .padding()
                        
                        HStack {
                            Text("Choose Your Source Currency")
                            Image(systemName: "chevron.down")
                                .onTapGesture {
                                    showArbList = false
                                    pickArbSource.toggle()
                                }
                        }
                        .padding(.bottom, 40)
                        
                        Text(arbVM.arbText)
                            .font(.title2)
                            .bold()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 100, height: 50)
                                    .foregroundColor(Color.theme.accent
                                    .opacity(0.2))
                            )
                            .padding(.bottom, 60)
                        
                        Button {
                            showArbList = true
                        } label: {
                            Text("Compute")
                                .bold()
                                .font(.headline)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .frame(width: 100, height: 50)
                                .foregroundColor(Color.theme.green)
                                .opacity(0.7)
                        )
                        .padding(.bottom, 40)
                        if (showArbList) {
                            
                            HStack {
                                ForEach(Array(arbVM.arbitrage), id: \.self) { arb in
                                    List {
                                        ForEach(Array(arb), id: \.self) { ar in
                                            Text(ar)
                                                .listRowBackground(Color.theme.background)
                                        }
                                    }
                                    .listStyle(PlainListStyle())
                                }
                            }
                            
                            HStack {
                                ForEach(Array(arbVM.pairs), id: \.self) { arb in
                                    List {
                                        let text = arb.reduce(1, *).show4decimals()
                                        Text(text)
                                            .foregroundColor(Color.theme.green)
                                            .fontWeight(.bold)
                                            .listRowBackground(Color.theme.background)
                                    }
                                    .listStyle(PlainListStyle())
                                }
                            }
                            
                        }
                        Spacer(minLength: 0)
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct ArbView_Previews: PreviewProvider {
    static var previews: some View {
        ArbView()
            .environmentObject(ArbVM())
    }
}

extension ArbView {
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
                CircleButtonView(name: "arrow.triangle.2.circlepath", opacity: colorScheme == .dark ? 0.8 : 0.6)
                Text("Arbitrage")
                    .font(.headline)
            }
        }
        .padding()
    }
}
