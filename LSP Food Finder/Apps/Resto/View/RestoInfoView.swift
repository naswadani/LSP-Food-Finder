//
//  RestoInfoView.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 09/01/25.
//

import SwiftUI

struct RestoInfoView: View {
    let resto: RestoDetailResponseModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ImageLoaderView(paddingButton: 0, imageURL: resto.imageURL, sizeFont: 25)
                    .frame(maxWidth: .infinity)
                    .frame(height: 250)
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                    .cornerRadius(10)
                    .padding(.bottom, 30)
                
                VStack(alignment: .leading, spacing: 15) {
                    Text(resto.description)
                        .font(.system(size: 18, weight: .regular, design: .rounded))
                        .multilineTextAlignment(.leading)
                    
                    Text("Address")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                    Text(resto.address)
                        .font(.system(size: 18, weight: .regular, design: .rounded))
                        .multilineTextAlignment(.leading)
                    
                    Text("Website")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                    Text(resto.website)
                        .font(.system(size: 18, weight: .regular, design: .rounded))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.blue)
                        .underline()
                        .onTapGesture {
                            if let url = URL(string: resto.website), UIApplication.shared.canOpenURL(url) {
                                UIApplication.shared.open(url)
                            }
                        }
                    
                    Text("Phone")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                    Text(resto.phone)
                        .font(.system(size: 18, weight: .regular, design: .rounded))
                }
                
                Spacer()
                    .frame(height: 80)
            }
            .padding(.horizontal)
        }
        .overlay(
            Group {
                if let lattitude = resto.lattitude, let longitude = resto.longitude {
                    NavigationLink(destination: MapView(
                        latitude: lattitude,
                        longitude: longitude,
                        restoName: resto.name
                    )) {
                        Image(systemName: "map.fill")
                            .font(.system(size: 30))
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
            
            
            .allowsHitTesting(true),
            alignment: .bottomTrailing
        )
    }
}


#Preview {
    RestoInfoView(resto: RestoDetailResponseModel(id: 15, name: "Resto Coba Saja Aku", owner: 76, description: "Ketika anda mencobanya maka akan terasa nikmat", address: "JL Pemuda", phone: "089736272930", website: "dinus.ac.id", lattitude: 37.4219983, longitude: -122.084, image: "/media/restaurant_images/Screenshot_20250107-145957.png", createdAt: "2025-01-08T07:31:25.696Z", updatedAt: "2025-01-08T17:09:48.409Z"))
}
