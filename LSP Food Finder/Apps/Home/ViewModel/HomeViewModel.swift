//
//  HomeViewModel.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 08/01/25.
//

import Foundation

enum HomeViewState {
    case idle
    case loading
    case empty(String)
    case error(String)
}

class HomeViewModel: ObservableObject {
    private let repository: HomeRepositoryProtocol
    private var isDataCanFetch: Bool = true
    
    @Published var state: HomeViewState = .idle
    @Published var searchBarText: String = ""
    @Published var restoList: [RestoDetailResponseModel] = []
    @Published var filteredRestoList: [RestoDetailResponseModel] = []
    @Published var idUser: UserProfileResponseModel?
    
    init(repository: HomeRepositoryProtocol) {
        self.repository = repository
    }
    
    func filterResto(by keyword: String) {
        if keyword.isEmpty {
            self.filteredRestoList = restoList
        } else {
            self.filteredRestoList = restoList.filter { $0.name.lowercased().contains(keyword.lowercased()) }
        }
    }
    
    private func updateHomeViewState(_ state: HomeViewState) {
        self.state = state
    }
    
    func refresh() {
        isDataCanFetch = true
        self.fetchResto()
        self.fetchProfileData()
    }
    
    func fetchResto() {
        guard isDataCanFetch else { return }
        guard let token = KeychainManager.shared.get(key: "access_token") else {
            return
        }
        
        updateHomeViewState(.loading)
        
        repository.fetchRestoList(token: token) {[weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.handleSuccessFetchRestoList(response)
                case .failure(let error):
                    self?.handleFailedFetchRestoList(error)
                }
            }
        }
    }
    
    private func handleSuccessFetchRestoList(_ response: [RestoDetailResponseModel]) {
        if response.isEmpty {
            updateHomeViewState(.empty("Maaf Data Kosong"))
            return
        }
        self.restoList = response
        self.filteredRestoList = response
        isDataCanFetch = false
        updateHomeViewState(.idle)
    }
    
    private func handleFailedFetchRestoList(_ error: Error) {
        isDataCanFetch = true
        updateHomeViewState(.error(error.localizedDescription))
    }
    
    func fetchProfileData() {
        guard let token = KeychainManager.shared.get(key: "access_token") else {
            return
        }
        
        repository.getProfileData(token: token) {[weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.handleSuccessFetchProfileData(response)
                case .failure(let error):
                    self?.handleFailedFetchProfileData(error)
                }
            }
        }
    }
    
    private func handleSuccessFetchProfileData(_ response: UserProfileResponseModel) {
        self.idUser = response
    }
    
    private func handleFailedFetchProfileData(_ error: Error) {
        updateHomeViewState(.error(error.localizedDescription))
    }
}
