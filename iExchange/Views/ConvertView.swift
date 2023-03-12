//
//  ConvertView.swift
//  iExchange
//
//  Created by Hala Mohammadi on 16/2/2023.
//

import SwiftUI

enum DestinationOrSource {
    case source
    case destination
    case arb
}

struct ConvertView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var convertVm : ConversionVM
    
    @State var pickSource : Bool = false
    @State var pickDest : Bool = false
    @State var showPath : Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.theme.background
                    .ignoresSafeArea()
                    .sheet(isPresented: $pickSource, content: {
                        PickCurrency(picked: "", sourceOrDest: .source)
                    })
                    .sheet(isPresented: $pickDest, content: {
                        PickCurrency(picked: "", sourceOrDest: .destination)
                    })
                
                VStack {
                    
                    homeHeader
                    Divider()
                    HStack {
                        Text("Convert")
                            .font(.headline)
                            .bold()
                    }
                    .padding()
                    
                    sourcePicker
                    
                    Text(convertVm.sourceText)
                        .font(.title2)
                        .bold()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 100, height: 50)
                                .foregroundColor(Color.theme.accent
                                    .opacity(0.2))
                        )
                        .padding(.bottom, 30)
                    
                    destinationPicker
                    
                    Text(convertVm.destinationText)
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
                        showPath = true
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
                    
                    if showPath {
                        if convertVm.shortestPath.count > 2 {
                            Text("Sequence Found!")
                                .foregroundColor(Color.theme.green)
                                .bold()
                            HStack {
                                Text("Cheapest Rate Sequence ==> \(convertVm.directOrSeq.show4decimals())")
                                    .foregroundColor(Color.theme.green)
                            }
                            .font(.headline)
                            
                            Text("Direct Rate ==> \(exp(convertVm.arbDict[convertVm.sourceText]?[convertVm.destinationText] ?? 0.0).show4decimals())")
                            
                        } else if convertVm.shortestPath.count == 2 {
                            VStack {
                                Text("No Sequence Found!")
                                    .foregroundColor(Color.theme.red)
                                    .bold()
                                Text("Direct Rate ==> \(convertVm.directOrSeq.show4decimals())")
                            }
                            .font(.headline)
                        }
                        List {
                            ForEach(convertVm.shortestPath, id: \.self) { element in
                                Text(element)
                                    .listRowBackground(Color.theme.background)
                            }
                        }
                        .listStyle(PlainListStyle())
                    }
                    Spacer(minLength: 0)
                }
            }
            .background()
        }
        .navigationBarBackButtonHidden(true)
        
    }
    
}

struct ConvertView_Previews: PreviewProvider {
    static var previews: some View {
        ConvertView()
            .environmentObject(ConversionVM())
    }
}

extension ConvertView {
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
                CircleButtonView(name: "arrow.left.arrow.right", opacity: colorScheme == .dark ? 0.8 : 0.6)
                Text("Convert")
                    .font(.headline)
            }
        }
        .padding()
    }
    
    private var sourcePicker : some View {
        HStack {
            Text("Choose Your Source Currency")
            Image(systemName: "chevron.down")
                .onTapGesture {
                    pickSource.toggle()
                    showPath = false
                }
        }
        .padding(.bottom, 30)
    }
    
    private var destinationPicker : some View {
        HStack {
            Text("Choose Your Destination Currency")
            Image(systemName: "chevron.down")
                .onTapGesture {
                    pickDest.toggle()
                    showPath = false
                }
        }
        .padding(.bottom, 30)
    }
}

