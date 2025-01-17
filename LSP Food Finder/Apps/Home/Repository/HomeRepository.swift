//
//  HomeRepository.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 08/01/25.
//

import Foundation

protocol HomeRepositoryProtocol {
    func fetchRestoList(token: String, completion: @escaping (Result<[RestoDetailResponseModel], Error>) -> Void)
    func getProfileData(token: String, completion: @escaping (Result<UserProfileResponseModel, Error>) -> Void)
}

class HomeRepository: HomeRepositoryProtocol {
    
    private let homeDataHandler: HomeDataHandlerProtocol
    
    init(homeDataHandler: HomeDataHandlerProtocol) {
        self.homeDataHandler = homeDataHandler
    }
    
    func fetchRestoList(token: String, completion: @escaping (Result<[RestoDetailResponseModel], any Error>) -> Void) {
        homeDataHandler.fetchRestoList(token: token, completion: completion)
    }
    func getProfileData(token: String, completion: @escaping (Result<UserProfileResponseModel, Error>) -> Void) {
        homeDataHandler.getProfileData(token: token, completion: completion)
    }

}
