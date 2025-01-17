//
//  SecuredTextInputComponentView.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 07/01/25.
//

import SwiftUI

struct SecuredTextInputComponentView: View {
    let instruction: String
    @State private var isView: Bool = false
    @Binding var password: String
    let useWhiteBackground: Bool
    var body: some View {
        HStack {
            Image(systemName: "lock.fill")
                .font(.system(size: 20))
                .padding(.trailing, 20)
                .foregroundColor(.black)
            if isView {
                TextField(instruction, text: $password)
                    .font(.system(size: 20, design: .rounded))
            } else {
                SecureField(instruction, text: $password)
                    .font(.system(size: 20, design: .rounded))
            }
            Spacer()
            Button(action:{
                isView.toggle()
            }) {
                Image(systemName: isView ? "eye.fill" : "eye.slash.fill")
                    .font(.system(size: 20))
                    .foregroundColor(.black)
            }
        }
        .padding()
        .background(
            Group {
                if useWhiteBackground {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                } else {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 1)
                        .background(Color.clear)
                }
            }
        )
    }
}

#Preview {
    SecuredTextInputComponentView(instruction: "ini untuk password", password: .constant(""), useWhiteBackground: false)
}
