//
//  ProfileView.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 08/01/25.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel: ProfileViewModel
    var body: some View {
        ZStack {
            Color.clear.ignoresSafeArea(.all)
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    Image("tes")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                        .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Account Info")
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                        
                        if let profile = viewModel.profileData {
                            InformationAccount(icon: "person.fill", type: "Username", value: profile.username)
                            InformationAccount(icon: "envelope.fill", type: "Email", value: profile.email)
                            InformationAccount(icon: "person", type: "Nama Depan", value: profile.firstName)
                            InformationAccount(icon: "person", type: "Nama Belakang", value: profile.lastName)
                        }
                        
                        
                        ButtonHorizontalFullScreenView(backgorundColor: Color.yellow, buttonTitle: "Update Profile", isEnabled: true, action: {
                            viewModel.displayAlertUpdateProfile()
                        })
                        ButtonHorizontalFullScreenView(backgorundColor: Color.yellow, buttonTitle: "Ganti Password", isEnabled: true, action: {
                            viewModel.displayAlertUpdatePassword()
                        })
                        
                        NavigationLink(destination: SegmentedControlProfileRestoView()) {
                            Text("Restoran Anda")
                                .foregroundColor(.black)
                                .font(.system(size: 25, design: .rounded))
                                .fontWeight(.semibold)
                        }
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.yellow)
                        )
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                }
            }
            switch viewModel.state {
            case .loading:
                Color.black.opacity(0.5).ignoresSafeArea(.all)
                LoadingView()
                    .transition(.opacity)
                    .zIndex(1)
            case .idle:
                EmptyView()
            case .error(let error):
                ErrorStateView(message: error, action: viewModel.refresh)
            case .errorUpdate(let error):
                Color.black.opacity(0.5).ignoresSafeArea(.all)
                AlertErrorView(message: error, action: viewModel.dismissAlert)
                    .zIndex(1)
            case .updateProfile:
                Color.black.opacity(0.5).ignoresSafeArea(.all)
                UpdateProfileAlertView(request: $viewModel.request, isEnabled: viewModel.isFormUpdateProfileValid, saveProfile: viewModel.updateProfileData, action: viewModel.dismissAlert)
                        .padding()
            case .updatePassword:
                Color.black.opacity(0.5).ignoresSafeArea(.all)
                UpdatePasswordAlertView(request: $viewModel.requestPassword, savePassword: viewModel.updatePassword, action: viewModel.dismissAlert, isEnabled: viewModel.isFormUpdatePasswordValid)
                    .padding()
            case .successUpdateProfile(let message):
                Color.black.opacity(0.5).ignoresSafeArea(.all)
                AlertSuccessView(message: message , action: viewModel.dismissAlert)
            }
            
        }
        .onAppear {
            viewModel.fetchProfileData()
        }
        .refreshable {
            viewModel.refresh()
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.large)
    }
}



struct InformationAccount: View {
    let icon: String
    let type: String
    let value: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.system(size: 25))
                .frame(width: 30, alignment: .center)
            VStack(alignment: .leading) {
                Text(type)
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                Text(value)
                    .foregroundColor(.gray)
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .multilineTextAlignment(.leading)
            }
        }
    }
}
