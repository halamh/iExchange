//
//  CurrencyRowView.swift
//  iExchange
//
//  Created by Hala Mohammadi on 14/2/2023.
//

import SwiftUI

struct CurrencyRowView: View {
    let currency : Result
    var body: some View {
        HStack {
            HStack(spacing: 3) {
                Text(currency.ticker1)
                Text("/")
                Text(currency.ticker2)
            }
            Spacer()
            Image(systemName: currency.percentageChange >= 0 ? "arrow.up" : "arrow.down")
                .font(.headline)
                .foregroundColor(currency.percentageChange >= 0 ? Color.theme.green : Color.theme.red)
            VStack(alignment: .trailing) {
                Text(currency.c.asNumberString())
                Text(currency.percentageChange.asNumberString())
                    .foregroundColor(currency.percentageChange >= 0 ? Color.theme.green : Color.theme.red)
            }
        }
        .padding(.horizontal, 9)
        .background(Color.theme.background)
    }
}

struct CurrencyRowView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyRowView(currency: DeveloperPreview.instance.pair.results[0])
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
