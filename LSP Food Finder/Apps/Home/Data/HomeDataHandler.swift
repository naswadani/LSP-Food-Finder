//
//  HomeDataHandler.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 08/01/25.
//

import Foundation
import Alamofire

protocol HomeDataHandlerProtocol {
    func fetchRestoList(token: String, completion: @escaping (Result<[RestoDetailResponseModel], Error>) -> Void)
    func getProfileData(token: String, completion: @escaping (Result<UserProfileResponseModel, Error>) -> Void)
}

class HomeDataHandler: HomeDataHandlerProtocol {
    func fetchRestoList(token: String, completion: @escaping (Result<[RestoDetailResponseModel], any Error>) -> Void) {
        let header = ["Authorization": "Bearer \(token)"]
        
        AF.request(APIConfig.getResto(), method: .get, headers: HTTPHeaders(header))
            .validate()
            .responseDecodable(of: [RestoDetailResponseModel].self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    
    func getProfileData(token: String, completion: @escaping (Result<UserProfileResponseModel, any Error>) -> Void) {
        let header = ["Authorization": "Bearer \(token)"]
        AF.request(APIConfig.getProfile(), method: .get, headers: HTTPHeaders(header))
            .validate()
            .responseDecodable(of: UserProfileResponseModel.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
