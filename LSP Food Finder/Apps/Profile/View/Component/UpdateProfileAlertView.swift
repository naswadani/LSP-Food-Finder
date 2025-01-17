//
//  UpdateProfileAlertView.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 09/01/25.
//

import SwiftUI

struct UpdateProfileAlertView: View {
    @Binding var request: UpdateProfileRequestModel
    let isEnabled: Bool
    let saveProfile: () -> Void
    let action: () -> Void
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Update Profile")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
            TextInputComponentView(instruction: "Email", icon: "envelope.fill", value: $request.email, useWhiteBackground: false)
            TextInputComponentView(instruction: "First Name", icon: "person", value: $request.firstName, useWhiteBackground: false)
            TextInputComponentView(instruction: "Last Name", icon: "person", value: $request.lastName, useWhiteBackground: false)
            ButtonHorizontalFullScreenView(backgorundColor: .yellow, buttonTitle: "Simpan Profile", isEnabled: isEnabled) {
                saveProfile()
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
        )
        .overlay(
            Button(action: {
                action()
            }) {
                Image(systemName: "xmark")
                    .font(.system(size: 20))
                    .foregroundColor(.black)
                    .offset(x: -15, y: 15)
            }, alignment: .topTrailing
        )
    }
}

