//
//  AlertSuccessView.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 09/01/25.
//

import SwiftUI

struct AlertSuccessView: View {
    let message: String
    let action: () -> Void
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.green)
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .padding(.top, 30)
            
            Text(message)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .padding(.bottom, 15)
        }
        .frame(width: 250)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(radius: 5)
        )
        .overlay(
            Button(action: {
                action()
                dismiss()
            }) {
                Image(systemName: "xmark")
                    .font(.system(size: 20))
                    .foregroundColor(.black)
                    .offset(x: -15, y: 15)
            }, alignment: .topTrailing
        )
        
    }
}

#Preview {
    AlertSuccessView(message: "Addien daya salsabila", action: {})
}

