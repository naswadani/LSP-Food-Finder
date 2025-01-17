import SwiftUI
import PhotosUI

struct PHPickerViewControllerRepresented: UIViewControllerRepresentable {
    @Binding var pickerItem: PHPickerResult?
    @Binding var isImagePickerPresented: Bool
    @Binding var selectedImage: UIImage? // Gambar yang dipilih
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        @Binding var pickerItem: PHPickerResult?
        @Binding var isImagePickerPresented: Bool
        @Binding var selectedImage: UIImage?
        
        init(pickerItem: Binding<PHPickerResult?>, isImagePickerPresented: Binding<Bool>, selectedImage: Binding<UIImage?>) {
            _pickerItem = pickerItem
            _isImagePickerPresented = isImagePickerPresented
            _selectedImage = selectedImage
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            guard let result = results.first else {
                isImagePickerPresented = false
                return
            }
            
            pickerItem = result
            isImagePickerPresented = false
            
            // Coba untuk memuat gambar
            if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
                    if let error = error {
                        print("Error loading image: \(error.localizedDescription)")
                    }
                    
                    if let image = object as? UIImage {
                        DispatchQueue.main.async {
                            self?.selectedImage = image // Simpan gambar yang dipilih ke binding
                        }
                    }
                }
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(pickerItem: $pickerItem, isImagePickerPresented: $isImagePickerPresented, selectedImage: $selectedImage)
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
