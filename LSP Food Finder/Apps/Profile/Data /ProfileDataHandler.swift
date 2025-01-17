//
//  ProfileDataHandler.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 09/01/25.
//

import Foundation
import Alamofire
import SwiftUI

protocol ProfileDataHandlerProtocol {
    func getProfileData(token: String, completion: @escaping (Result<UserProfileResponseModel, Error>) -> Void)
    func updateProfileData(request: UpdateProfileRequestModel, token: String, completion: @escaping (Result<UserProfileResponseModel, Error>) -> Void)
    func updatePassword(request: UpdatePasswordRequestModel, token: String, completion: @escaping (Result<UpdatePasswordResponseModel, Error>) -> Void)
    func createResto(request: EditRestoRequestModel, token: String, completion: @escaping (Result<RestoDetailResponseModel, Error>) -> Void)
    func editResto(id: Int, request: EditRestoRequestModel, token: String, completion: @escaping (Result<RestoDetailResponseModel, Error>) -> Void)
    func fetchMenu(id: Int, token: String, completion: @escaping (Result<[MenuDetailResponseModel], Error>) -> Void)
    func createMenu(id: Int, request: CreateMenuRequestModel, token: String, completion: @escaping (Result<MenuDetailResponseModel, Error>) -> Void)
    func deleteMenu(id: Int, token: String, completion: @escaping (Result<Void, Error>) -> Void)
    func uploadImageResto(token: String, image: UIImage, id: Int, completion: @escaping (Result<Void, Error>) -> Void)
    func uploadImageMenu(token: String, image: UIImage, id: Int, completion: @escaping (Result<Void, Error>) -> Void) 
}

class ProfileDataHandler: ProfileDataHandlerProtocol {
    func updateProfileData(request: UpdateProfileRequestModel, token: String, completion: @escaping (Result<UserProfileResponseModel, any Error>) -> Void) {
        let header = ["Authorization": "Bearer \(token)"]
        
        AF.request(APIConfig.getProfile(), method: .put, parameters: request, encoder: JSONParameterEncoder.default, headers: HTTPHeaders(header))
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
    
    func updatePassword(request: UpdatePasswordRequestModel, token: String, completion: @escaping (Result<UpdatePasswordResponseModel, any Error>) -> Void) {
        let header = ["Authorization": "Bearer \(token)"]
        AF.request(APIConfig.updateProfilePassword(), method: .put, parameters: request, encoder: JSONParameterEncoder.default, headers: HTTPHeaders(header))
            .validate()
            .responseDecodable(of: UpdatePasswordResponseModel.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func createResto(request: EditRestoRequestModel, token: String, completion: @escaping (Result<RestoDetailResponseModel, Error>) -> Void) {
        let header = ["Authorization": "Bearer \(token)"]
        AF.request(APIConfig.getResto(), method: .post, parameters: request, encoder: JSONParameterEncoder.default, headers: HTTPHeaders(header))
            .validate()
            .responseDecodable(of: RestoDetailResponseModel.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func editResto(id: Int, request: EditRestoRequestModel, token: String, completion: @escaping (Result<RestoDetailResponseModel, Error>) -> Void) {
        let header = ["Authorization": "Bearer \(token)"]
        AF.request(APIConfig.getRestoById(id: id), method: .put, parameters: request, encoder: JSONParameterEncoder.default, headers: HTTPHeaders(header))
            .validate()
            .responseDecodable(of: RestoDetailResponseModel.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
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
    
    func createMenu(id: Int, request: CreateMenuRequestModel, token: String, completion: @escaping (Result<MenuDetailResponseModel, Error>) -> Void) {
        let header = ["Authorization": "Bearer \(token)"]
        AF.request(APIConfig.getMenuByRestoId(id: id), method: .post, parameters: request, encoder: JSONParameterEncoder.default, headers: HTTPHeaders(header))
            .validate()
            .responseDecodable(of: MenuDetailResponseModel.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func deleteMenu(id: Int, token: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let header = ["Authorization": "Bearer \(token)"]

        AF.request(APIConfig.getMenuById(id: id), method: .delete, headers: HTTPHeaders(header))
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
    
    func uploadImageResto(token: String, image: UIImage, id: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        let header = ["Authorization": "Bearer \(token)"]
        
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            return
        }
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "image", fileName: "resto.jpg", mimeType: "image/jpeg")
        }, to: APIConfig.postImageResto(id: id), headers: HTTPHeaders(header))
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
    
    
    func uploadImageMenu(token: String, image: UIImage, id: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        let header = ["Authorization": "Bearer \(token)"]
        
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            return
        }
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "image", fileName: "menu.jpg", mimeType: "image/jpeg")
        }, to: APIConfig.postImageMenu(id: id), headers: HTTPHeaders(header))
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
