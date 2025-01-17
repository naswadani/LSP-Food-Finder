//
//  EditMenuView.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 17/01/25.
//

import SwiftUI
import PhotosUI

struct EditMenuView: View {
    @Environment(\.dismiss) private var dismiss
    let selectedMenuId: Int
    @State private var selectedImage: UIImage?
    @StateObject var viewModel: ListMenuViewModel
    @State private var isImagePickerPresented = false
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
                
                if let selectedImage = selectedImage {
                    ButtonHorizontalFullScreenView(backgorundColor: .yellow, buttonTitle: "Tambah Gambar", isEnabled: true) {
                        viewModel.uploadRestoImage(image: selectedImage, selectedId: selectedMenuId)
                        dismiss()
                    }
                }
                
                ButtonHorizontalFullScreenView(backgorundColor: .yellow, buttonTitle: "Hapus", isEnabled: true) {
                    viewModel.deleteMenu(id: selectedMenuId)
                    dismiss()
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
    }
}
