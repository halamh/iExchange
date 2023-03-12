//
//  PickCurrency.swift
//  iExchange
//
//  Created by Hala Mohammadi on 17/2/2023.
//

import SwiftUI



struct PickCurrency: View {
    
    @EnvironmentObject var arbVM : ArbVM
    @EnvironmentObject var conversionVm : ConversionVM
    
    @State var picked : String = ""
    var sourceOrDest : DestinationOrSource
    
    @Environment(\.dismiss) var dismiss
    @State var check : Bool = false
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    Spacer()
                    Button {
                        sourceOrDest == .source ? conversionVm.updateSource(text: picked) : (sourceOrDest == .destination ? conversionVm.updateDestination(text: picked) : arbVM.updateArb(text: picked))
                        
                        picked = ""
                        dismiss()
                    } label: {
                        Text("Done")
                    }
                    .font(.title3)
                    .padding(.top, 10)
                }
                .padding(.horizontal, 25)
                .opacity(picked.isEmpty ? 0.0 : 1.0)

                
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search by name or ticker...", text: sourceOrDest == .source ? $conversionVm.sourceText : (sourceOrDest == .destination ? $conversionVm.destinationText : $arbVM.arbText))
                        .disableAutocorrection(true)
                        
                    Spacer()
                    Image(systemName: "xmark")
                        .opacity(
                            sourceOrDest == .source ? (conversionVm.sourceText.isEmpty ? 0.0 : 1.0) : (sourceOrDest == .destination ? (conversionVm.destinationText.isEmpty ? 0.0 : 1.0) :
                                (arbVM.arbText.isEmpty ? 0.0 : 1.0))
                        )
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            if (sourceOrDest == .source) {
                                conversionVm.sourceText = ""
                            } else if (sourceOrDest == .destination) {
                                conversionVm.destinationText = ""
                            } else if (sourceOrDest == .arb) {
                                arbVM.arbText = ""
                            }
                        }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 50)
                        .foregroundColor(Color.theme.background)
                        .shadow(color: Color.theme.accent.opacity(0.3), radius: 5, x: 0, y: 0)
                )
                .padding()
                
                
                if (sourceOrDest == .arb) {
                    List {
                        ForEach(arbVM.currencies, id: \.self) { currency in
                            HStack {
                                Text(currency)
                                    .listRowBackground(Color.theme.background)
                                    .onTapGesture {
                                        picked = currency
                                    }
                                Spacer()
                                if (picked == currency) {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(Color.theme.green)
                                }
                            }
                            .listRowBackground(Color.theme.background)
                        }
                    }
                    .listStyle(PlainListStyle())
                } else if (sourceOrDest == .source) {
                    List {
                        ForEach(conversionVm.currencies, id: \.self) { currency in
                            HStack {
                                Text(currency)
                                    .listRowBackground(Color.theme.background)
                                    .onTapGesture {
                                        picked = currency
                                    }
                                Spacer()
                                if (picked == currency) {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(Color.theme.green)
                                }
                            }
                            .listRowBackground(Color.theme.background)
                        }
                    }
                    .listStyle(PlainListStyle())
                } else if (sourceOrDest == .destination) {
                    List {
                        ForEach(conversionVm.corresponding, id: \.self) { currency in
                            HStack {
                                Text(currency)
                                    .listRowBackground(Color.theme.background)
                                    .onTapGesture {
                                        picked = currency
                                    }
                                Spacer()
                                if (picked == currency) {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(Color.theme.green)
                                }
                            }
                            .listRowBackground(Color.theme.background)
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
        }
    }
    
    
}

struct PickCurrency_Previews: PreviewProvider {
    static var previews: some View {
        PickCurrency(picked: "", sourceOrDest: .source)
            .environmentObject(ArbVM())
            .environmentObject(ConversionVM())
    }
}
