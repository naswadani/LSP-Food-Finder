//
//  CreateRestoProfileViewModel.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 10/01/25.
//

import Foundation
import Alamofire

class CreateRestoProfileViewModel: ObservableObject {
    private let repository: ProfileRepositoryProtocol
    private var selectedRestoID: Int?
    
    @Published var request: EditRestoRequestModel
    @Published var isFormEditRestoValid: Bool = false

    init(repository: ProfileRepositoryProtocol, selectedRestoID: Int?) {
        self.selectedRestoID = selectedRestoID
        self.repository = repository
        self.request = EditRestoRequestModel(name: "", description: "", address: "", phone: "", website: "", lattitude: 0, longitude: 0)
        self.setupEditRestoProfileValidation()
    }
    
    func createProfileResto() {
        guard let token = KeychainManager.shared.get(key: "access_token") else {
            return
        }
        repository.createResto(request: request, token: token) {[weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.handleSuccessCreateResto(response)
                case .failure(let error):
                    self?.handleFailedCreateResto(error)
                }
            }
        }
    }
    
    func editProfileResto() {
        guard let token = KeychainManager.shared.get(key: "access_token") else {
            return
        }
        
        guard let id = selectedRestoID else {
            return
        }
        repository.editResto(id: id , request: request, token: token) {[weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.handleSuccessCreateResto(response)
                case .failure(let error):
                    self?.handleFailedCreateResto(error)
                }
            }
        }
    }
    func uploadRestoImage(image: UIImage) {
        
        guard let token = KeychainManager.shared.get(key: "access_token") else {
            return
        }
        
        guard let id = selectedRestoID else {
            return
        }
        
        repository.uploadImageResto(token: token, image: image, id: id) {[weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    print("success")
                case .failure(let error):
                    print("failed")
                }
            }
        }
    }
    
    private func handleSuccessCreateResto(_ response: RestoDetailResponseModel) {
        self.request = EditRestoRequestModel(name: "", description: "", address: "", phone: "", website: "", lattitude: 0, longitude: 0)
    }
    
    private func handleFailedCreateResto(_ error: Error) {
        
    }
    
    private func setupEditRestoProfileValidation() {
        $request
            .map { request in
                return !request.name.isEmpty &&
                !request.description.isEmpty &&
                !request.address.isEmpty &&
                !request.phone.isEmpty &&
                !request.website.isEmpty &&
                request.lattitude != 0 &&
                request.longitude != 0
            }
            .assign(to: &$isFormEditRestoValid)
    }
    
}


struct RestoImageRequest {
    var image: Data?
    var fileName: String?
}
