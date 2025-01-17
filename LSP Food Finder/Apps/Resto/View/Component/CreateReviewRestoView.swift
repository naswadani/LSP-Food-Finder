//
//  CreateReviewRestoView.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 11/01/25.
//

import SwiftUI

struct CreateReviewRestoView: View {
    @Environment(\.dismiss) private var dismiss
    let action: () -> Void
    @Binding var request: CreateReviewRestoRequestModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            TextInputComponentView(instruction: "Comment", icon: "fork.knife", value: $request.comment , useWhiteBackground: false)
            HStack {
                Image(systemName: "star.fill")
                    .frame(width: 25, alignment: .center)
                    .font(.system(size: 20))
                    .padding(.trailing, 20)
                TextField("Rating", text: Binding(
                        get: { String(request.rating) },
                        set: { request.rating = Int($0) ?? 0 }
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
            ButtonHorizontalFullScreenView(backgorundColor: .yellow, buttonTitle: "Simpan Menu", isEnabled: true) {
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
