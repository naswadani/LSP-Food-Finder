//
//  ProfileRestoView.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 10/01/25.
//

import SwiftUI

struct ProfileRestoView: View {
    @StateObject var viewModel: ProfileRestoViewModel
    @Binding var selectedId: Int?

    var body: some View {
        ScrollView {
            switch viewModel.state {
            case .idle:
                VStack(alignment: .leading) {
                    if let resto = viewModel.profileData?.restaurant {
                        ImageLoaderView(paddingButton: 0, imageURL: resto.imageURL, sizeFont: 25)
                            .frame(maxWidth: .infinity)
                            .frame(height: 250)
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                            .cornerRadius(10)
                            .padding(.bottom, 30)
                    }
                     
                    VStack(alignment: .leading, spacing: 15) {
                        if let resto = viewModel.profileData?.restaurant {
                            InformationAccount(icon: "fork.knife", type: "Nama Resto", value: resto.name)
                            InformationAccount(icon: "document.fill", type: "Deskripsi", value: resto.description)
                            InformationAccount(icon: "location.fill", type: "Alamat", value: resto.address)
                            InformationAccount(icon: "phone.fill", type: "No Telepon", value: resto.phone)
                            InformationAccount(icon: "globe", type: "Website", value: resto.website)
                            InformationAccount(icon: "mappin", type: "Lat/Long", value: "\(String(describing: resto.lattitude)), \(String(describing: resto.longitude))")
                        }
                        
                    }
                    
                    NavigationLink(destination: EditProfileRestoView(viewModel: CreateRestoProfileViewModel(repository: ProfileRepository(profileDataHandler: ProfileDataHandler()), selectedRestoID: viewModel.profileData?.restaurant?.id))) {
                        Text("Edit Restoran")
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
                .padding()
            case .isNill:
                VStack {
                    Spacer()
                    NavigationLink(destination: CreateRestoProfileView(viewModel: CreateRestoProfileViewModel(repository: ProfileRepository(profileDataHandler: ProfileDataHandler()), selectedRestoID: viewModel.profileData?.restaurant?.id))) {
                        Text("Daftar Restoran")
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
                    Spacer()
                }
                .padding()
            case .error(let error):
                ErrorStateView(message: error, action: {})
            case .loading:
                ZStack {
                    Color.white.ignoresSafeArea(.all)
                    ProgressView()
                        .foregroundColor(.gray)
                        .padding()
                }
            }
            
        }
        .onAppear {
            viewModel.fetchProfileData()
        }
        .onReceive(viewModel.$selectedRestoID) { selectedId in
            if let id = selectedId {
                self.selectedId = id
            }
        }

    }
}


