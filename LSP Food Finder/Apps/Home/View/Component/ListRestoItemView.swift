//
//  ListRestoItemView.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 08/01/25.
//

import SwiftUI

struct ListRestoItemView: View {
    let data: RestoDetailResponseModel
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer()
            HStack {
                VStack(alignment: .leading, spacing: 15) {
                    Text(data.name)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.black)
                        .lineLimit(1)
                    Text(data.description)
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.black)
                        .lineLimit(1)
                }
                Spacer()
                Button(action: {
                    makePhoneCall(to: data.phone)
                }) {
                    Image(systemName: "phone.fill")
                        .font(.system(size: 20))
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.yellow)
                                .shadow(radius: 5, x: 1, y: 1)
                        )
                }
            }
            .padding(15)
            .frame(maxWidth: .infinity)
            .background(
                UnevenRoundedRectangle(cornerRadii: .init(bottomLeading: 10, bottomTrailing: 10))
                    .fill(Color("yellowColor"))
            )
            
            
        }
        .frame(maxWidth: .infinity)
        .frame(height: 250)
        .background(
            ImageLoaderView(paddingButton: 20 , imageURL: data.imageURL, sizeFont: 25)
        )
        .cornerRadius(10)
    }
    
    func makePhoneCall(to phoneNumber: String) {
        let cleanedPhoneNumber = phoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        if let phoneURL = URL(string: "tel://\(cleanedPhoneNumber)"),
           UIApplication.shared.canOpenURL(phoneURL) {
            UIApplication.shared.open(phoneURL)
        } else {
            print("Nomor telepon tidak valid atau perangkat tidak mendukung panggilan telepon.")
        }
    }
}

#Preview {
    ListRestoItemView(data: RestoDetailResponseModel(id: 15, name: "Resto Coba Saja Aku", owner: 76, description: "Ketika anda mencobanya maka akan terasa nikmat", address: "JL Pemuda", phone: "089736272930", website: "dinus.ac.id", lattitude: 37.4219983, longitude: -122.084, image: "/media/restaurant_images/Screenshot_20250107-145957.png", createdAt: "2025-01-08T07:31:25.696Z", updatedAt: "2025-01-08T17:09:48.409Z"))
}
