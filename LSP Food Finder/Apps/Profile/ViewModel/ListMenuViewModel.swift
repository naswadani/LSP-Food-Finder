//
//  ListMenuViewModel.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 10/01/25.
//

import SwiftUI
import Foundation

enum ListMenuState {
    case idle
    case loading
    case empty(String)
    case error(String)
}

class ListMenuViewModel: ObservableObject {
    private let repository: ProfileRepositoryProtocol
    private var isDataCanFetch: Bool = true
    private var selectedRestoId: Int?
    
    
    @Published var state: ListMenuState = .idle
    @Published var menuList: [MenuDetailResponseModel] = []
    @Published var requestMenu: CreateMenuRequestModel
    @Published var isFormCreateMenuValid: Bool = false
    
    init(repository: ProfileRepositoryProtocol, selectedRestoId: Int?) {
        self.repository = repository
        self.selectedRestoId = selectedRestoId
        self.requestMenu = CreateMenuRequestModel(restaurantId: 0, name: "", description: "", price: nil)
        self.setupEditRestoProfileValidation()
    }
    
    private func updateListMenuState(_ state: ListMenuState) {
        self.state = state
    }
    
    func createMenu() {
        guard let token = KeychainManager.shared.get(key: "access_token") else {
            return
        }
        
        guard let id = selectedRestoId else {
            return
        }
        updateListMenuState(.loading)
        
        repository.createMenu(id: id, request: requestMenu, token: token) {[weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.handleSuccessCreateMenu(response)
                case .failure(let failure):
                    self?.handleFailedCreateMenu(failure)
                }
            }
        }
    }
    
    private func handleSuccessCreateMenu(_ response: MenuDetailResponseModel) {
        self.requestMenu = CreateMenuRequestModel(restaurantId: 0, name: "", description: "", price: nil)
        self.refresh()
    }
    
    private func handleFailedCreateMenu(_ error: Error) {
        updateListMenuState(.error(error.localizedDescription))
    }
    
    
    func fetchMenuList() {
        guard isDataCanFetch else { return }
        
        guard let token = KeychainManager.shared.get(key: "access_token") else {
            return
        }
        guard let id = selectedRestoId else {
            return
        }
        
        updateListMenuState(.loading)
        
        repository.fetchMenu(id: id, token: token) { [weak self] result in
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
            updateListMenuState(.empty("Menu Masih Kosong"))
            return
        }
        self.menuList = response
        self.isDataCanFetch = false
        updateListMenuState(.idle)
    }
    
    func deleteMenu(id: Int?) {
        guard let token = KeychainManager.shared.get(key: "access_token") else {
            return
        }
        
        guard let idMenu = id else {
            return
        }
        
        updateListMenuState(.loading)
        
        repository.deleteMenu(id: idMenu, token: token) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.updateListMenuState(.idle)
                    self?.refresh()
                case .failure(let error):
                    self?.updateListMenuState(.error(error.localizedDescription))
                }
            }
        }
        
    }
    
    private func handleFailedFetchMenuList(_ error: Error) {
        self.isDataCanFetch = true
        updateListMenuState(.error(error.localizedDescription))
    }
    
    func refresh() {
        self.isDataCanFetch = true
        fetchMenuList()
    }
    
    private func setupEditRestoProfileValidation() {
        $requestMenu
            .map { request in
                return !request.name.isEmpty &&
                !request.description.isEmpty
            }
            .assign(to: &$isFormCreateMenuValid)
    }
    
    func uploadRestoImage(image: UIImage, selectedId: Int) {
        
        guard let token = KeychainManager.shared.get(key: "access_token") else {
            return
        }
        
        repository.uploadImageMenu(token: token, image: image, id: selectedId) {[weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    print("ok")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
}


