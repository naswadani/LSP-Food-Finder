//
//  TextInputComponentView.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 07/01/25.
//

import SwiftUI

struct TextInputComponentView: View {
    let instruction: String
    let icon: String
    @Binding var value: String
    let useWhiteBackground: Bool
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .frame(width: 25, alignment: .center)
                .font(.system(size: 20))
                .padding(.trailing, 20)
            TextField(instruction, text: $value)
                .font(.system(size: 20, design: .rounded))
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
    TextInputComponentView(instruction: "Addien Daya Salsabila", icon: "person.fill", value: .constant(""), useWhiteBackground: false)
}
