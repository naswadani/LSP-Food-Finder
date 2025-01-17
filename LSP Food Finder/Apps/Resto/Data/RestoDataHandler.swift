//
//  RestoDataHandler.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 09/01/25.
//

import Alamofire
import Foundation

protocol RestoDataHandlerProtocol {
    func fetchMenu(id: Int, token: String, completion: @escaping (Result<[MenuDetailResponseModel], Error>) -> Void)
    func fetchRestoReview(id: Int, token: String, completion: @escaping(Result<[ReviewResponseModel], Error>) -> Void)
    func createRestoReview(request: CreateReviewRestoRequestModel, id: Int, token: String, completion: @escaping(Result<ReviewResponseModel, Error>) -> Void)
    func updateRestoReview(request: CreateReviewRestoRequestModel, id: Int, token: String, completion: @escaping(Result<ReviewResponseModel, Error>) -> Void)
    func deleteRestoReview(id: Int, token: String, completion: @escaping (Result<Void, Error>) -> Void)
}

class RestoDataHandler: RestoDataHandlerProtocol {
    func fetchMenu(id: Int, token: String, completion: @escaping (Result<[MenuDetailResponseModel], any Error>) -> Void) {
        let header = ["Authorization": "Bearer \(token)"]
        
        AF.request(APIConfig.getMenuByRestoId(id: id), method: .get, headers: HTTPHeaders(header))
            .validate()
            .responseDecodable(of: [MenuDetailResponseModel].self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchRestoReview(id: Int, token: String, completion: @escaping(Result<[ReviewResponseModel], Error>) -> Void) {
        let header = ["Authorization": "Bearer \(token)"]
        
        AF.request(APIConfig.getReview(id: id), method: .get, headers: HTTPHeaders(header))
            .validate()
            .responseDecodable(of: [ReviewResponseModel].self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func createRestoReview(request: CreateReviewRestoRequestModel, id: Int, token: String, completion: @escaping (Result<ReviewResponseModel, Error>) -> Void) {
        let header = ["Authorization": "Bearer \(token)"]
        AF.request(APIConfig.getReview(id: id), method: .post, parameters: request, encoder: JSONParameterEncoder.default, headers: HTTPHeaders(header))
            .validate()
            .responseDecodable(of: ReviewResponseModel.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func updateRestoReview(request: CreateReviewRestoRequestModel, id: Int, token: String, completion: @escaping (Result<ReviewResponseModel, any Error>) -> Void) {
        let header = ["Authorization": "Bearer \(token)"]
        AF.request(APIConfig.editReview(id: id), method: .put, parameters: request, encoder: JSONParameterEncoder.default, headers: HTTPHeaders(header))
            .validate()
            .responseDecodable(of: ReviewResponseModel.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func deleteRestoReview(id: Int, token: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let header = ["Authorization": "Bearer \(token)"]
        
        AF.request(APIConfig.editReview(id: id), method: .delete, headers: HTTPHeaders(header))
            .validate()
            .response { response in
                switch response.result {
                case .success:
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

}
