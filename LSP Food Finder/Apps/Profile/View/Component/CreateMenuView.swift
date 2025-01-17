//
//  CreateMenuView.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 10/01/25.
//

import SwiftUI

struct CreateMenuView: View {
    @Environment(\.dismiss) private var dismiss
    let action: () -> Void
    @Binding var request: CreateMenuRequestModel
    let isEnabled: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            TextInputComponentView(instruction: "Judul Menu", icon: "fork.knife", value: $request.name , useWhiteBackground: false)
            TextInputComponentView(instruction: "Description", icon: "document.fill", value: $request.description , useWhiteBackground: false)
            HStack {
                Image(systemName: "dollarsign")
                    .frame(width: 25, alignment: .center)
                    .font(.system(size: 20))
                    .padding(.trailing, 20)
                TextField("Masukkan harga", text: Binding(
                        get: { String(request.price) },
                        set: { request.price = Double($0) ?? 0 }
                    ))
                    .font(.system(size: 20, design: .rounded))
            }
            .padding()
            .background(
                Group {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 1)
                        .background(Color.clear)
                }
            )
            ButtonHorizontalFullScreenView(backgorundColor: .yellow, buttonTitle: "Simpan Menu", isEnabled: isEnabled) {
                action()
                dismiss()
            }
            
            Spacer()
            
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
        )
    }
}

