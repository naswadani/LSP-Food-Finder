//
//  RestoRepository.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 09/01/25.
//

import Foundation


protocol RestoRepositoryProtocol {
    func fetchMenu(id: Int, token: String, completion: @escaping (Result<[MenuDetailResponseModel], Error>) -> Void)
    func fetchRestoReview(id: Int, token: String, completion: @escaping(Result<[ReviewResponseModel], Error>) -> Void)
    func createRestoReview(request: CreateReviewRestoRequestModel, id: Int, token: String, completion: @escaping (Result<ReviewResponseModel, Error>) -> Void)
    func updateRestoReview(request: CreateReviewRestoRequestModel, id: Int, token: String, completion: @escaping (Result<ReviewResponseModel, any Error>) -> Void)
    func deleteRestoReview(id: Int, token: String, completion: @escaping (Result<Void, Error>) -> Void)
}

class RestoRepository: RestoRepositoryProtocol {
    private let restoDataHandler: RestoDataHandlerProtocol
    
    init(restoDataHandler: RestoDataHandlerProtocol) {
        self.restoDataHandler = restoDataHandler
    }
    
    func fetchMenu(id: Int, token: String, completion: @escaping (Result<[MenuDetailResponseModel], Error>) -> Void) {
        restoDataHandler.fetchMenu(id: id, token: token, completion: completion)
    }
    
    func fetchRestoReview(id: Int, token: String, completion: @escaping(Result<[ReviewResponseModel], Error>) -> Void) {
        restoDataHandler.fetchRestoReview(id: id, token: token, completion: completion)
    }

    func createRestoReview(request: CreateReviewRestoRequestModel, id: Int, token: String, completion: @escaping (Result<ReviewResponseModel, Error>) -> Void) {
        restoDataHandler.createRestoReview(request: request, id: id, token: token, completion: completion)
    }
    func updateRestoReview(request: CreateReviewRestoRequestModel, id: Int, token: String, completion: @escaping (Result<ReviewResponseModel, any Error>) -> Void) {
        restoDataHandler.updateRestoReview(request: request, id: id, token: token, completion: completion)
    }
    func deleteRestoReview(id: Int, token: String, completion: @escaping (Result<Void, Error>) -> Void) {
        restoDataHandler.deleteRestoReview(id: id, token: token, completion: completion)
    }
}
