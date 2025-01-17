//
//  ProfileRestoViewModel.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 10/01/25.
//

import Foundation
import Alamofire

enum ProfileRestoStateView {
    case isNill
    case idle
    case loading
    case error(String)
}


class ProfileRestoViewModel: ObservableObject {
    private let repository: ProfileRepositoryProtocol
    
    @Published var selectedRestoID: Int? = nil
    @Published var request: EditRestoRequestModel
    @Published var state: ProfileRestoStateView = .idle
    @Published var profileData: UserProfileResponseModel?

    init(repository: ProfileRepositoryProtocol) {
        self.repository = repository
        self.request = EditRestoRequestModel(name: "", description: "", address: "", phone: "", website: "", lattitude: 0, longitude: 0)
        
    }
    
    private func updateProfileRestoState(_ state: ProfileRestoStateView) {
        self.state = state
    }
    
    func fetchProfileData() {
        guard let token = KeychainManager.shared.get(key: "access_token") else {
            return
        }
        
        updateProfileRestoState(.loading)
        
        repository.getProfileData(token: token) {[weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.handleSuccessFetchProfileData(response)
                case .failure(let error):
                    self?.handleFailedFetchProfileData(error)
                }
            }
        }
    }
    
    private func handleSuccessFetchProfileData(_ response: UserProfileResponseModel) {
        guard response.restaurant != nil else {
            updateProfileRestoState(.isNill)
            return
        }
        self.profileData = response
        self.selectedRestoID = response.restaurant?.id
        updateProfileRestoState(.idle)
    }
    
    
    
    private func handleFailedFetchProfileData(_ error: Error) {
        updateProfileRestoState(.error(error.localizedDescription))
    }
    
    
}
