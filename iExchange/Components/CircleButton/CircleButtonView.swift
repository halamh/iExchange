//
//  CircleButtonView.swift
//  iExchange
//
//  Created by Hala Mohammadi on 12/2/2023.
//

import SwiftUI

struct CircleButtonView: View {
    let name : String
    let opacity : Double
    var body: some View {
        Image(systemName: name)
            .font(.headline)
            .foregroundColor(Color.theme.accent)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .foregroundColor(Color.theme.background)
            )
            .shadow(color: Color.theme.accent.opacity(opacity), radius: 10, x: 0, y: 0)
            .padding(.horizontal)
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CircleButtonView(name: "briefcase", opacity: 0.25)
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
            CircleButtonView(name: "arrow.left.arrow.right", opacity: 0.25)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.light)
        }
        
    }
}
