//
//  UpdatePasswordAlertView.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 09/01/25.
//

import SwiftUI

struct UpdatePasswordAlertView: View {
    @Binding var request: UpdatePasswordRequestModel
    let savePassword: () -> Void
    let action: () -> Void
    let isEnabled: Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Update Password")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
            SecuredTextInputComponentView(instruction: "Old Password", password: $request.oldPassword, useWhiteBackground: false)
            SecuredTextInputComponentView(instruction: "New Password", password: $request.newPassword, useWhiteBackground: false)
            SecuredTextInputComponentView(instruction: "Confirmation", password: $request.confirmation, useWhiteBackground: false)
            ButtonHorizontalFullScreenView(backgorundColor: .yellow, buttonTitle: "Ganti Password", isEnabled: isEnabled) {
                savePassword()
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
