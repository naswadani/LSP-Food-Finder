//
//  MenuListViewModel.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 09/01/25.
//

import Foundation

enum MenuListState {
    case idle
    case loading
    case empty(String)
    case error(String)
}

class MenuListViewModel: ObservableObject {
    private let repository: RestoRepositoryProtocol
    private var isDataCanFetch: Bool = true
    private var selectedRestoId: Int
    
    var selectedReviewID: Int
    @Published var state: MenuListState = .idle
    @Published var menuList: [MenuDetailResponseModel] = []
    @Published var reviewList: [ReviewResponseModel] = []
    @Published var userId: Int
    @Published var requestCreateReview: CreateReviewRestoRequestModel
    @Published var requestCreateMenuRating: CreateMenuRatingRequestModel
    @Published var ratingMenuList: [MenuRatingResponseModel] = []
    
    init(repository: RestoRepositoryProtocol, selectedRestoId: Int, userId: Int) {
        self.repository = repository
        self.selectedRestoId = selectedRestoId
        self.userId = userId
        self.requestCreateReview = CreateReviewRestoRequestModel(restaurantID: 0, userID: 0, rating: 0, comment: "")
        self.requestCreateMenuRating = CreateMenuRatingRequestModel(rating: nil)
        self.selectedReviewID = 0
    }
    
    private func updateMenuListState(_ state: MenuListState) {
        self.state = state
    }
    
    func selectID(_ id: Int) {
        self.selectedReviewID = id
    }
    
    func refresh() {
        self.isDataCanFetch = true
        fetchMenuList()
    }
    
    func refreshReview() {
        self.isDataCanFetch = true
        fetchRestoReview()
    }
    
    func fetchRestoReview() {
        guard isDataCanFetch else { return }
        guard let token = KeychainManager.shared.get(key: "access_token") else {
            return
        }
        
        updateMenuListState(.loading)
        
        repository.fetchRestoReview(id: selectedRestoId, token: token) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.handleSuccessFetchReviewList(response)
                case .failure(let error):
                    self?.handleFailedFetchReviewList(error)
                }
            }
        }
    }
    
    func createReview() {
        guard let token = KeychainManager.shared.get(key: "access_token") else {
            return
        }
        
        updateMenuListState(.loading)
        
        requestCreateReview.userID = userId
        requestCreateReview.restaurantID = selectedRestoId
        
        repository.createRestoReview(request: requestCreateReview, id: selectedRestoId, token: token) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.handleSuccessCreateReview(response)
                case .failure(let error):
                    self?.handleFailedCreateReview(error)
                }
            }
        }
        
    }
    
    func updateReview() {
        guard let token = KeychainManager.shared.get(key: "access_token") else {
            return
        }
        
        guard selectedReviewID != 0 else { return }
        
        updateMenuListState(.loading)
        
        requestCreateReview.userID = userId
        requestCreateReview.restaurantID = selectedRestoId
        
        repository.updateRestoReview(request: requestCreateReview, id: selectedReviewID, token: token) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.handleSuccessCreateReview(response)
                case .failure(let error):
                    self?.handleFailedCreateReview(error)
                }
            }
        }
        
    }
    
    func deleteReview() {
        guard let token = KeychainManager.shared.get(key: "access_token") else {
            return
        }
        
        guard selectedReviewID != 0 else { return }
        
        updateMenuListState(.loading)
        requestCreateReview.userID = userId
        requestCreateReview.restaurantID = selectedRestoId
        
        repository.deleteRestoReview(id: selectedReviewID, token: token) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.refreshReview()
                case .failure(let error):
                    self?.handleFailedCreateReview(error)
                }
            }
        }
    }
    
    func fetchMenuList() {
        guard isDataCanFetch else { return }
        guard let token = KeychainManager.shared.get(key: "access_token") else {
            return
        }
        
        updateMenuListState(.loading)
        
        repository.fetchMenu(id: selectedRestoId, token: token) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.handleSuccessFetchMenuList(response)
                case .failure(let error):
                    self?.handleFailedFetchMenuList(error)
                }
            }
        }
    }
    
    private func handleSuccessFetchMenuList(_ response: [MenuDetailResponseModel]) {
        guard !response.isEmpty else {
            updateMenuListState(.empty("Menu Masih Kosong"))
            return
        }
        self.menuList = response
        self.isDataCanFetch = false
        updateMenuListState(.idle)
    }
    
    private func handleFailedFetchMenuList(_ error: Error) {
        self.isDataCanFetch = true
        updateMenuListState(.error(error.localizedDescription))
    }
    
    private func handleSuccessFetchReviewList(_ response: [ReviewResponseModel]) {
        guard !response.isEmpty else {
            updateMenuListState(.empty("Menu Masih Kosong"))
            return
        }
        
        self.reviewList = response
        self.isDataCanFetch = false
        updateMenuListState(.idle)
    }
    
    private func handleFailedFetchReviewList(_ error: Error) {
        updateMenuListState(.error(error.localizedDescription))
    }
    
    private func handleSuccessCreateReview(_ reponse: ReviewResponseModel) {
        self.requestCreateReview = CreateReviewRestoRequestModel(restaurantID: 0, userID: 0, rating: 0, comment: "")
        self.refreshReview()
    }
    
    private func handleFailedCreateReview(_ error: Error) {
        updateMenuListState(.error(error.localizedDescription))
    }
    
    
    func fetchMenuRating(id: Int) {
        guard let token = KeychainManager.shared.get(key: "access_token") else {
            return
        }
        
        repository.fetchMenuRating(id: id, token: token) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.handleSuccessFetchMenuRatingList(response)
                case .failure(let error):
                    self?.handleFailedFetchReviewList(error)
                }
            }
        }
    }
    
    func createMenuRating(id: Int) {
        guard let token = KeychainManager.shared.get(key: "access_token") else {
            return
        }
        
        repository.createMenuRating(request: requestCreateMenuRating, id: id, token: token) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.fetchMenuRating(id: id)
                    self?.requestCreateMenuRating = CreateMenuRatingRequestModel(rating: nil)
                case .failure(let error):
                    self?.handleFailedFetchReviewList(error)
                }
            }
            
        }
    }
    
    private func handleSuccessFetchMenuRatingList(_ response: [MenuRatingResponseModel]) {
        self.ratingMenuList = response
    }
}


