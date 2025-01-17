//
//  AuthRepository.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 07/01/25.
//

import Foundation

protocol AuthRepositoryProtocol {
    func userLogin(loginRequest: UserLoginRequestModel, completion: @escaping (Result<UserLoginResponseModel, Error>) -> Void)
    func userRegister(registerRequest: UserRegisterRequestModel, completion: @escaping (Result<UserRegisterResponseModel, Error>) -> Void)
    func tokenRefresh(refreshRequest: UserRefreshTokenResponseModel, completion: @escaping (Result<UserRefreshTokenResponseModel, Error>) -> Void)
}

class AuthRepository: AuthRepositoryProtocol {
    private let authDataHandler: AuthDataHandlerProtocol
    init(authDataHandler: AuthDataHandlerProtocol) {
        self.authDataHandler = authDataHandler
    }
    
    func userLogin(loginRequest: UserLoginRequestModel,
                   completion: @escaping (Result<UserLoginResponseModel, Error>) -> Void) {
        authDataHandler.userLogin(loginRequest: loginRequest, completion: completion)
    }
    func userRegister(registerRequest: UserRegisterRequestModel,
                      completion: @escaping (Result<UserRegisterResponseModel, Error>) -> Void) {
        authDataHandler.userRegister(registerRequest: registerRequest, completion: completion)
    }
    func tokenRefresh(refreshRequest: UserRefreshTokenResponseModel,
                      completion: @escaping (Result<UserRefreshTokenResponseModel, Error>) -> Void) {
        authDataHandler.tokenRefresh(refreshRequest: refreshRequest, completion: completion)
    }
}
