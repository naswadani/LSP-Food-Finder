//
//  APIConfig.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 06/01/25.
//

import Foundation

struct APIConfig {
    static let baseURL: String = {
        guard let url: String =  Bundle.main.object(forInfoDictionaryKey: "APIBaseURL") as? String else {
            fatalError("Missing API Base URL")
        }
        return url
    }()
    
    static func postRegister() -> String {
        return "\(baseURL)/api/register"
    }
    
    static func getResto() -> String {
        return "\(baseURL)/api/resto"
    }
    
    static func postImageResto(id: Int) -> String {
        return "\(baseURL)/api/resto/\(id)/image"
    }
    
    static func getRestoById(id: Int) -> String {
        return "\(baseURL)/api/resto/\(id)"
    }
    
    static func getProfile() -> String {
        return "\(baseURL)/api/profile"
    }
    
    static func updateProfilePassword() -> String {
        return "\(baseURL)/api/profile/password"
    }
    
    static func getMenuByRestoId(id: Int) -> String {
        return "\(baseURL)/api/resto/\(id)/menu"
    }
    
    static func postImageMenu(id: Int) -> String {
        return "\(baseURL)/api/menu/\(id)/image"
    }
    
    static func getMenuById(id: Int) -> String {
        return "\(baseURL)/api/menu/\(id)"
    }
    
    static func postSignIn() -> String {
        return "\(baseURL)/api/auth/sign-in"
    }
    
    static func refreshToken() -> String {
        return "\(baseURL)/api/auth/token-refresh"
    }
    
    static func getReview(id: Int) -> String {
        return "\(baseURL)/api/resto/\(id)/review"
    }
    
    static func editReview(id: Int) -> String {
        return "\(baseURL)/api/review/\(id)"
    }
}
