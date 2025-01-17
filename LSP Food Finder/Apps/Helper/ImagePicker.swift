import SwiftUI
import PhotosUI

struct ImagePicker: View {
    @Binding var isImagePickerPresented: Bool
    var sourceType: UIImagePickerController.SourceType
    var uploadMenuImageData: (Data) -> Void

    @State private var pickerItem: PHPickerResult?
    @State private var selectedImage: UIImage? 

    var body: some View {
        VStack {
            if let uiImage = selectedImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
                    .frame(height: 250)
                    .cornerRadius(10)
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
                        .fill(.gray.opacity(0.3))
                )
            }

            PHPickerViewControllerRepresented(pickerItem: $pickerItem, isImagePickerPresented: $isImagePickerPresented, selectedImage: $selectedImage, uploadMenuImageData: uploadMenuImageData)
                .onChange(of: pickerItem) { newItem in
                    if let item = newItem {
                        loadImage(from: item)
                    }
                }

            Button(action: {
                isImagePickerPresented.toggle()
            }) {
                Text("Choose Image")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding()
        }
        .onChange(of: selectedImage) { newImage in
            if let image = newImage, let data = image.jpegData(compressionQuality: 0.5) {
                uploadMenuImageData(data)  // This will upload the image data
            }
        }
    }
    
    private func loadImage(from item: PHPickerResult) {
        let itemProvider = item.itemProvider
        if itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { (object, error) in
                if let image = object as? UIImage {
                    DispatchQueue.main.async {
                        selectedImage = image
                    }
                }
            }
        }
    }
}

struct PHPickerViewControllerRepresented: UIViewControllerRepresentable {
    @Binding var pickerItem: PHPickerResult?
    @Binding var isImagePickerPresented: Bool
    @Binding var selectedImage: UIImage?  // Bind ke selectedImage bukan imageData
    
    var uploadMenuImageData: (Data) -> Void
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        @Binding var pickerItem: PHPickerResult?
        @Binding var isImagePickerPresented: Bool
        @Binding var selectedImage: UIImage?  // Bind ke selectedImage bukan imageData
        
        var uploadMenuImageData: (Data) -> Void
        
        init(pickerItem: Binding<PHPickerResult?>, isImagePickerPresented: Binding<Bool>, selectedImage: Binding<UIImage?>, uploadMenuImageData: @escaping (Data) -> Void) {
            _pickerItem = pickerItem
            _isImagePickerPresented = isImagePickerPresented
            _selectedImage = selectedImage
            self.uploadMenuImageData = uploadMenuImageData
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            guard let result = results.first else {
                isImagePickerPresented = false
                return
            }
            pickerItem = result
            isImagePickerPresented = false
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(pickerItem: $pickerItem, isImagePickerPresented: $isImagePickerPresented, selectedImage: $selectedImage, uploadMenuImageData: uploadMenuImageData)
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
}
