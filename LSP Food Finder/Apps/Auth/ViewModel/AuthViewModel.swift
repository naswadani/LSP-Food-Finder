//
//  LoginViewModel.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 07/01/25.
//

import Foundation

enum AuthViewState {
    case idle
    case loading
    case failure(String)
}

class AuthViewModel: ObservableObject {
    private let repository: AuthRepositoryProtocol
    
    @Published var requestLogin: UserLoginRequestModel
    @Published var requestRegister: UserRegisterRequestModel
    
    @Published var state: AuthViewState = .idle
    @Published var loginSuccess: Bool = false
    @Published var registerSuccess: Bool = false
    @Published var isFormLoginValid: Bool = false
    @Published var isFormRegisterValid: Bool = false

    
    init(repository: AuthRepositoryProtocol) {
        self.repository = repository
        self.requestLogin = UserLoginRequestModel(username: "", password: "")
        self.requestRegister = UserRegisterRequestModel(
            username: "",
            password: "",
            confirmation: "",
            email: "",
            firstName: "",
            lastName: ""
        )
        setupLoginValidation()
        setupRegisterValidation()
    }
    
    private func updateAuthState(_ state: AuthViewState) {
        self.state = state
    }
    
    func userLogin(request: UserLoginRequestModel) {
        updateAuthState(.loading)
        repository.userLogin(loginRequest: request) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.handleSuccessUserLogin(response)
                case .failure(let error):
                    self?.handleFailureUserLogin(error)
                }
            }
        }
    }
    
    func userRegistration(request: UserRegisterRequestModel) {
        repository.userRegister(registerRequest: request) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.handleSuccessUserRegister(response)
                case .failure(let error):
                    self?.handleFailureUserRegister(error)
                }
            }
        }
    }
    
    private func handleSuccessUserLogin(_ response: UserLoginResponseModel) {
        KeychainManager.shared.save(key: "access_token", value: response.access)
        KeychainManager.shared.save(key: "refresh_token", value: response.refresh)
        loginSuccess = true
        updateAuthState(.idle)
    }
    
    private func handleSuccessUserRegister(_ response: UserRegisterResponseModel) {
        self.requestRegister = UserRegisterRequestModel(
            username: "",
            password: "",
            confirmation: "",
            email: "",
            firstName: "",
            lastName: ""
        )
        registerSuccess = true
        updateAuthState(.idle)
    }
    
    private func handleFailureUserLogin(_ error: Error) {
        updateAuthState(.failure(error.localizedDescription))
    }
    
    private func handleFailureUserRegister(_ error: Error) {
        updateAuthState(.failure(error.localizedDescription))
    }
    
    private func setupLoginValidation() {
        $requestLogin
            .map { request in
                return !request.username.isEmpty &&
                !request.password.isEmpty
            }
            .assign(to: &$isFormLoginValid)
    }
    
    private func setupRegisterValidation() {
        $requestRegister
            .map { request in
                return !request.username.isEmpty &&
                !request.firstName.isEmpty &&
                !request.lastName.isEmpty &&
                !request.email.isEmpty &&
                !request.password.isEmpty &&
                !request.confirmation.isEmpty
            }
            .assign(to: &$isFormRegisterValid)
    }
    
    func dismissAlert() {
        updateAuthState(.idle)
    }
}
