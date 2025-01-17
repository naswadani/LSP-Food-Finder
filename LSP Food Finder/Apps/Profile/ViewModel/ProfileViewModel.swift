//
//  ProfileViewModel.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 09/01/25.
//

import Foundation

enum ProfileViewState {
    case idle
    case loading
    case error(String)
    case updateProfile
    case updatePassword
    case successUpdateProfile(String)
    case errorUpdate(String)
}

class ProfileViewModel: ObservableObject {
    private let repository: ProfileRepositoryProtocol
    private var isDataCanFetch: Bool = true
    
    @Published var state: ProfileViewState = .idle
    @Published var profileData: UserProfileResponseModel?
    @Published var request: UpdateProfileRequestModel
    @Published var requestPassword: UpdatePasswordRequestModel
    @Published var isFormUpdateProfileValid: Bool = false
    @Published var isFormUpdatePasswordValid: Bool = false
    
    init(repository: ProfileRepositoryProtocol) {
        self.repository = repository
        self.request = UpdateProfileRequestModel(email: "", firstName: "", lastName: "")
        self.requestPassword = UpdatePasswordRequestModel(oldPassword: "", newPassword: "", confirmation: "")
        setupUpdateProfileValidation()
        setupUpdatePasswordValidation()
    }
    
    private func updateProfileState(_ state: ProfileViewState) {
        self.state = state
    }
    
    func refresh() {
        isDataCanFetch = true
        fetchProfileData()
    }
    
    func updatePassword() {
        guard let token = KeychainManager.shared.get(key: "access_token") else {
            return
        }
        
        updateProfileState(.loading)
        
        repository.updatePassword(request: requestPassword, token: token) {[weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.handleSuccessUpdatePassword(response)
                case .failure(let error):
                    self?.handleFailedUpdatePassword(error)
                }
            }
        }
    }
    
    func updateProfileData() {
        guard let token = KeychainManager.shared.get(key: "access_token") else {
            return
        }
        
        updateProfileState(.loading)
        
        repository.updateProfileData(request: request, token: token) {[weak self] result in
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
    
    func fetchProfileData() {
        guard isDataCanFetch else { return }
        guard let token = KeychainManager.shared.get(key: "access_token") else {
            return
        }
        
        updateProfileState(.loading)
        
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
        self.profileData = response
        self.isDataCanFetch = false
        updateProfileState(.idle)
    }
    
    private func handleSuccessUpdateProfileData(_ response: UserProfileResponseModel) {
        self.profileData = response
        self.request = UpdateProfileRequestModel(email: "", firstName: "", lastName: "")
        updateProfileState(.idle)
    }

    private func handleSuccessUpdatePassword(_ response: UpdatePasswordResponseModel) {
        updateProfileState(.successUpdateProfile(response.message))
        self.requestPassword = UpdatePasswordRequestModel(oldPassword: "", newPassword: "", confirmation: "")
    }
    
    private func handleFailedUpdatePassword(_ error: Error) {
        updateProfileState(.errorUpdate(error.localizedDescription))
    }
    
    private func handleFailedUpdateProfileData(_ error: Error) {
        updateProfileState(.errorUpdate(error.localizedDescription))
    }
    
    private func handleFailedFetchProfileData(_ error: Error) {
        self.isDataCanFetch = true
        updateProfileState(.error(error.localizedDescription))
    }
    
    func dismissAlert() {
        self.updateProfileState(.idle)
    }
    
    private func setupUpdateProfileValidation() {
        $request
            .map { request in
                return !request.email.isEmpty &&
                !request.firstName.isEmpty &&
                !request.lastName.isEmpty
            }
            .assign(to: &$isFormUpdateProfileValid)
    }
        
    private func setupUpdatePasswordValidation() {
        $requestPassword
            .map { request in
                return !request.oldPassword.isEmpty &&
                !request.newPassword.isEmpty &&
                !request.confirmation.isEmpty
            }
            .assign(to: &$isFormUpdatePasswordValid)
    }
    
    func displayAlertUpdateProfile() {
        updateProfileState(.updateProfile)
    }
    
    func displayAlertUpdatePassword() {
        updateProfileState(.updatePassword)
    }
    
}
