//
//  UserRegisterRequestModel.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 06/01/25.
//

import Foundation

struct UserRegisterRequestModel: Codable {
    var username: String
    var password: String
    var confirmation: String
    var email: String
    var firstName: String
    var lastName: String
    
    enum CodingKeys: String, CodingKey {
        case username
        case password
        case confirmation
        case email
        case firstName = "first_name"
        case lastName = "last_name"
    }
    
}
