//
//  KeychainManager.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 07/01/25.
//

import Foundation
import KeychainSwift

protocol KeychainManagerProtocol {
    func save(key: String, value: String)
    func get(key: String) -> String?
    func delete(key: String)
}

class KeychainManager: KeychainManagerProtocol {
    
    static let shared: KeychainManager = KeychainManager()
    private let keychain: KeychainSwift = KeychainSwift()
    
    init() {}
    
    func save(key: String, value: String) {
        keychain.set(value, forKey: key)
    }
    
    func get(key: String) -> String? {
        return keychain.get(key)
    }
    
    func delete(key: String) {
        keychain.delete(key)
    }
}
