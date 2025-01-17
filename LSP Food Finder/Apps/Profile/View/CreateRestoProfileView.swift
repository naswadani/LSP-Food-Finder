//
//  CreateProfileView.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 10/01/25.
//

import SwiftUI

struct CreateRestoProfileView: View {
    @StateObject var viewModel: CreateRestoProfileViewModel
    @StateObject private var locationManager = LocationManager()
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 20) {
                VStack(alignment: .leading) {
                    Text("Nama Resto")
                        .font(.system(size: 18, weight: .regular, design: .rounded))
                    TextInputComponentView(instruction: "Nama Resto", icon: "fork.knife", value: $viewModel.request.name, useWhiteBackground: false)
                    
                    Text("Deskripsi")
                        .font(.system(size: 18, weight: .regular, design: .rounded))
                    TextInputComponentView(instruction: "Deskripsi Resto", icon: "document.fill", value: $viewModel.request.description, useWhiteBackground: false)
                    
                    Text("Alamat")
                        .font(.system(size: 18, weight: .regular, design: .rounded))
                    TextInputComponentView(instruction: "Alamat", icon: "location.fill", value: $viewModel.request.address, useWhiteBackground: false)
                    
                    Text("No Telepon")
                        .font(.system(size: 18, weight: .regular, design: .rounded))
                    TextInputComponentView(instruction: "No Telp", icon: "phone.fill", value: $viewModel.request.phone, useWhiteBackground: false)
                    
                    Text("Website")
                        .font(.system(size: 18, weight: .regular, design: .rounded))
                    TextInputComponentView(instruction: "Website", icon: "globe", value: $viewModel.request.website, useWhiteBackground: false)
                    
                    Text("Lat/Long")
                        .font(.system(size: 18, weight: .regular, design: .rounded))
                    HStack {
                        if let longitude = locationManager.longitude, let lattitude = locationManager.latitude {
                            TextLongLatView(value: "\(lattitude), \(longitude)" , icon: "mappin")
                        } else {
                            TextLongLatView(value: "", icon: "mappin")
                        }
                        
                        Button(action: {
                            locationManager.requestLocation()
                        }) {
                            Image(systemName: "map.fill")
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(.yellow)
                                )
                                .padding()
                        }
                    }
                }
                
                ButtonHorizontalFullScreenView(backgorundColor: .yellow, buttonTitle: "Simpan Restoran", isEnabled: viewModel.isFormEditRestoValid, action: {
                    viewModel.createProfileResto()
                })
            }
            .padding(.horizontal)
        }
        .onReceive(locationManager.$latitude) { newLatitude in
            viewModel.request.lattitude = newLatitude ?? 0
        }
        .onReceive(locationManager.$longitude) { newLongitude in
            viewModel.request.longitude = newLongitude ?? 0

        }
    }
}
