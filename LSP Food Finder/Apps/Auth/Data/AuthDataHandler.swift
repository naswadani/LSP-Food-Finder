//
//  AuthDataHandler.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 06/01/25.
//

import Foundation
import Alamofire

protocol AuthDataHandlerProtocol {
    func userLogin(loginRequest: UserLoginRequestModel, completion: @escaping (Result<UserLoginResponseModel, Error>) -> Void)
    func userRegister(registerRequest: UserRegisterRequestModel, completion: @escaping (Result<UserRegisterResponseModel, Error>) -> Void)
    func tokenRefresh(refreshRequest: UserRefreshTokenResponseModel, completion: @escaping (Result<UserRefreshTokenResponseModel, Error>) -> Void)
}

class AuthDataHandler: AuthDataHandlerProtocol {
    func userLogin(loginRequest: UserLoginRequestModel, completion: @escaping (Result<UserLoginResponseModel, Error>) -> Void) {
        AF.request(APIConfig.postSignIn(), method: .post, parameters: loginRequest, encoder: JSONParameterEncoder.default)
            .validate()
            .responseDecodable(of: UserLoginResponseModel.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func userRegister(registerRequest: UserRegisterRequestModel, completion: @escaping (Result<UserRegisterResponseModel, any Error>) -> Void) {
        AF.request(APIConfig.postRegister(), method: .post, parameters: registerRequest, encoder: JSONParameterEncoder.default)
            .validate()
            .responseDecodable(of: UserRegisterResponseModel.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func tokenRefresh(refreshRequest: UserRefreshTokenResponseModel, completion: @escaping (Result<UserRefreshTokenResponseModel, any Error>) -> Void) {
        AF.request(APIConfig.refreshToken(), method: .post, parameters: refreshRequest, encoder: JSONParameterEncoder.default)
            .validate()
            .responseDecodable(of: UserRefreshTokenResponseModel.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
                
            }
    }
}
