//
//  RegisterView.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 07/01/25.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel: AuthViewModel

    var body: some View {
        ZStack {
            Color.yellow.opacity(0.5).ignoresSafeArea(.all)
            VStack(spacing: 20) {
                Text("Food Finder")
                    .foregroundColor(.black)
                    .font(.system(size: 35, design: .rounded))
                    .fontWeight(.bold)
                
                TextInputComponentView(
                    instruction: "Username",
                    icon: "person.fill",
                    value: $viewModel.requestRegister.username,
                    useWhiteBackground: true
                )
                
                TextInputComponentView(
                    instruction: "Nama Depan",
                    icon: "person",
                    value: $viewModel.requestRegister.firstName,
                    useWhiteBackground: true
                )
                
                TextInputComponentView(
                    instruction: "Nama Belakang",
                    icon: "person",
                    value: $viewModel.requestRegister.lastName,
                    useWhiteBackground: true
                )
                
                TextInputComponentView(
                    instruction: "Email",
                    icon: "envelope.fill",
                    value: $viewModel.requestRegister.email,
                    useWhiteBackground: true
                )
                
                SecuredTextInputComponentView(
                    instruction: "Password",
                    password: $viewModel.requestRegister.password,
                    useWhiteBackground: true
                )
                
                SecuredTextInputComponentView(
                    instruction: "Konfirmasi Password",
                    password: $viewModel.requestRegister.confirmation,
                    useWhiteBackground: true
                )
                
                ButtonHorizontalFullScreenView(
                    backgorundColor: Color.white,
                    buttonTitle: "Register",
                    isEnabled: viewModel.isFormRegisterValid,
                    action: {
                        viewModel.userRegistration(request: viewModel.requestRegister)
                    }
                )
                
                Button(action: {
                    dismiss()
                }) {
                    Text("Sudah Punya Akun? Login di sini")
                        .font(.system(size: 18, design: .rounded))
                        .fontWeight(.medium)
                        .foregroundColor(.blue)

                }
            }
            .padding()
            
            switch viewModel.state {
            case .idle:
                EmptyView()
            case .loading:
                Color.black.opacity(0.5).ignoresSafeArea(.all)
                LoadingView()
                    .transition(.opacity)
                    .zIndex(1)
            case .failure(let error):
                Color.black.opacity(0.5).ignoresSafeArea(.all)
                AlertErrorView(message: error) {
                    viewModel.dismissAlert()
                }
                .zIndex(1)
            }
        }
    }
}

