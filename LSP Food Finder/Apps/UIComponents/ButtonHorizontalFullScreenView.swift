//
//  ButtonHorizontalFullScreenView.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 07/01/25.
//

import SwiftUI

struct ButtonHorizontalFullScreenView: View {
    let backgorundColor: Color
    let buttonTitle: String
    let isEnabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            if isEnabled == true {
                action()
            }
        }) {
            Text(buttonTitle)
                .foregroundColor(isEnabled == true ? .black : .gray)
                .font(.system(size: 25, design: .rounded))
                .fontWeight(.semibold)
        }
        .frame(height: 55)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(isEnabled == true ? backgorundColor : Color.gray.opacity(0.3))
        )
        .disabled(isEnabled != true)
    }
}


#Preview {
    ButtonHorizontalFullScreenView(backgorundColor: .blue, buttonTitle: "Login", isEnabled: false, action: {})
}
