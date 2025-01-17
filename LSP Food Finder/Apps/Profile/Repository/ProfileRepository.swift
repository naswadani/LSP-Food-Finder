//
//  ProfileRepository.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 09/01/25.
//

import Foundation
import SwiftUI

protocol ProfileRepositoryProtocol {
    func getProfileData(token: String, completion: @escaping (Result<UserProfileResponseModel, Error>) -> Void)
    func updateProfileData(request: UpdateProfileRequestModel, token: String, completion: @escaping (Result<UserProfileResponseModel, Error>) -> Void)
    func updatePassword(request: UpdatePasswordRequestModel, token: String, completion: @escaping (Result<UpdatePasswordResponseModel, Error>) -> Void)
    func createResto(request: EditRestoRequestModel, token: String, completion: @escaping (Result<RestoDetailResponseModel, Error>) -> Void)
    func editResto(id: Int, request: EditRestoRequestModel, token: String, completion: @escaping (Result<RestoDetailResponseModel, Error>) -> Void)
    func fetchMenu(id: Int, token: String, completion: @escaping (Result<[MenuDetailResponseModel], Error>) -> Void)
    func createMenu(id: Int, request: CreateMenuRequestModel, token: String, completion: @escaping (Result<MenuDetailResponseModel, Error>) -> Void)
    func deleteMenu(id: Int, token: String, completion: @escaping (Result<Void, Error>) -> Void)
    func uploadImageResto(token: String, image: UIImage, id: Int, completion: @escaping (Result<Void, Error>) -> Void)
}

class ProfileRepository: ProfileRepositoryProtocol {
    private let profileDataHandler: ProfileDataHandlerProtocol
    
    init(profileDataHandler: ProfileDataHandlerProtocol) {
        self.profileDataHandler = profileDataHandler
    }
    
    func getProfileData(token: String, completion: @escaping (Result<UserProfileResponseModel, Error>) -> Void) {
        profileDataHandler.getProfileData(token: token, completion: completion)
    }
    
    func updateProfileData(request: UpdateProfileRequestModel, token: String, completion: @escaping (Result<UserProfileResponseModel, Error>) -> Void) {
        profileDataHandler.updateProfileData(request: request, token: token, completion: completion)
    }
    
    func updatePassword(request: UpdatePasswordRequestModel, token: String, completion: @escaping (Result<UpdatePasswordResponseModel, Error>) -> Void) {
        profileDataHandler.updatePassword(request: request, token: token, completion: completion)
    }
    
    func createResto(request: EditRestoRequestModel, token: String, completion: @escaping (Result<RestoDetailResponseModel, Error>) -> Void) {
        profileDataHandler.createResto(request: request, token: token, completion: completion)
    }
    
    func editResto(id: Int, request: EditRestoRequestModel, token: String, completion: @escaping (Result<RestoDetailResponseModel, Error>) -> Void) {
        profileDataHandler.editResto(id: id, request: request, token: token, completion: completion)
    }

    func fetchMenu(id: Int, token: String, completion: @escaping (Result<[MenuDetailResponseModel], Error>) -> Void) {
        profileDataHandler.fetchMenu(id: id, token: token, completion: completion)
    }
    
    func createMenu(id: Int, request: CreateMenuRequestModel, token: String, completion: @escaping (Result<MenuDetailResponseModel, Error>) -> Void) {
        profileDataHandler.createMenu(id: id, request: request, token: token, completion: completion)
    }
    
    func deleteMenu(id: Int, token: String, completion: @escaping (Result<Void, Error>) -> Void) {
        profileDataHandler.deleteMenu(id: id, token: token, completion: completion)
    }

    func uploadImageResto(token: String, image: UIImage, id: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        profileDataHandler.uploadImageResto(token: token, image: image, id: id, completion: completion)
    }
}
