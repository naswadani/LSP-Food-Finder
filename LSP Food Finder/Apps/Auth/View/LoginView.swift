//
//  LoginView.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 07/01/25.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
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
                        value: $viewModel.requestLogin.username,
                        useWhiteBackground: true
                    )
                    SecuredTextInputComponentView(
                        instruction: "Password",
                        password: $viewModel.requestLogin.password,
                        useWhiteBackground: true
                    )
                    
                    ButtonHorizontalFullScreenView(
                        backgorundColor: Color.white,
                        buttonTitle:  "Login",
                        isEnabled: viewModel.isFormLoginValid,
                        action: {
                            viewModel.userLogin(request: viewModel.requestLogin)
                        }
                    )
                    
                    NavigationLink(destination: RegisterView(viewModel: viewModel)) {
                        Text("Belum Punya Akun? Daftar di sini")
                            .font(.system(size: 18, design: .rounded))
                            .fontWeight(.medium)
                            .foregroundColor(.blue)
                    }
                }
                .padding()
                
                switch viewModel.state {
                case .loading:
                    Color.black.opacity(0.5).ignoresSafeArea(.all)
                    LoadingView()
                        .transition(.opacity)
                        .zIndex(1)
                case .idle:
                    EmptyView()
                case .failure(let error):
                    Color.black.opacity(0.5).ignoresSafeArea(.all)
                    AlertErrorView(message: error) {
                        viewModel.dismissAlert()
                    }
                    .zIndex(1)
                }
            }
            .preferredColorScheme(.light)
            .navigationDestination(isPresented: $viewModel.loginSuccess) { TabBarView() }
        }
    }
}
