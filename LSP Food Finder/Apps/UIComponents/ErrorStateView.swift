//
//  ErrorStateView.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 09/01/25.
//

import SwiftUI

struct ErrorStateView: View {
    let message: String
    let action: () -> Void
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "x.circle")
                .font(.system(size: 30))
                .fontWeight(.bold)
                .foregroundColor(.red)
            Text(message)
                .font(.system(size: 25, weight: .bold, design: .rounded))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            Button(action: {
                action()
            }) {
                Text("Refresh")
                    .font(.system(size: 20))
                    .fontWeight(.regular)
                    .foregroundColor(.black)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.yellow)
                    )
                    .padding(.top, 100)
            }
        }
    }
}

#Preview {
    ErrorStateView(message: "Maaf Error", action: {})
}
