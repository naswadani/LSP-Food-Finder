import SwiftUI
import PhotosUI

struct EditProfileRestoView: View {
    
    @StateObject var viewModel: CreateRestoProfileViewModel
    @State private var isImagePickerPresented = false
    @State private var selectedImage: UIImage?
    @StateObject private var locationManager = LocationManager()
    @State private var pickerItem: PHPickerResult?
    
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 20) {
                
                if let selectedImage = selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .frame(maxWidth: .infinity)
                        .frame(height: 250)
                        .cornerRadius(10)
                        .clipped()
                } else {
                    ZStack {
                        Color.gray.opacity(0.3)
                        Image(systemName: "photo.on.rectangle")
                            .font(.system(size: 25))
                    }
                    .frame(height: 250)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.3))
                    )
                }
                
                ButtonHorizontalFullScreenView(backgorundColor: .yellow, buttonTitle: "Gallery", isEnabled: true, action: {
                    isImagePickerPresented = true
                })
                
                
                VStack(alignment: .leading, spacing: 15) {
                    formSection(label: "Nama Resto", icon: "fork.knife", value: $viewModel.request.name)
                    formSection(label: "Deskripsi", icon: "document.fill", value: $viewModel.request.description)
                    formSection(label: "Alamat", icon: "location.fill", value: $viewModel.request.address)
                    formSection(label: "No Telepon", icon: "phone.fill", value: $viewModel.request.phone)
                    formSection(label: "Website", icon: "globe", value: $viewModel.request.website)
                    
                    Text("Lat/Long")
                        .font(.system(size: 18, weight: .regular, design: .rounded))
                    
                    HStack {
                        if let longitude = locationManager.longitude, let latitude = locationManager.latitude {
                            TextLongLatView(value: "\(latitude), \(longitude)", icon: "mappin")
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
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.yellow))
                        }
                    }
                }
                
                ButtonHorizontalFullScreenView(backgorundColor: .yellow, buttonTitle: "Simpan Restoran", isEnabled: viewModel.isFormEditRestoValid) {
                    viewModel.editProfileResto()
                    viewModel.uploadRestoImage(image: selectedImage!)
                }
            }
            .padding(.horizontal)
            .sheet(isPresented: $isImagePickerPresented) {
                PHPickerViewControllerRepresented(
                    pickerItem: .constant(nil),
                    isImagePickerPresented: $isImagePickerPresented,
                    selectedImage: $selectedImage
                )
            }
            
        }
        .onReceive(locationManager.$latitude) { newLatitude in
            viewModel.request.lattitude = newLatitude ?? 0
        }
        .onReceive(locationManager.$longitude) { newLongitude in
            viewModel.request.longitude = newLongitude ?? 0
        }
    }
    
    private func formSection(label: String, icon: String, value: Binding<String>) -> some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.system(size: 18, weight: .regular, design: .rounded))
            TextInputComponentView(instruction: label, icon: icon, value: value, useWhiteBackground: false)
        }
    }
}

struct TextLongLatView: View {
    let value: String
    let icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .frame(width: 25, alignment: .center)
                .font(.system(size: 20))
                .padding(.trailing, 20)
            
            Text(value)
                .font(.system(size: 20, design: .rounded))
                .foregroundColor(.black)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 1)
                .background(Color.clear)
        )
    }
}

