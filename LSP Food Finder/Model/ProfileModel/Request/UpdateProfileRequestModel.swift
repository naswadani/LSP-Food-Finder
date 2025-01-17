//
//  UpdateProfileRequestModel.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 09/01/25.
//

import Foundation

struct UpdateProfileRequestModel: Codable {
    var email: String
    var firstName: String
    var lastName: String
    
    enum CodingKeys: String, CodingKey {
        case email
        case firstName = "first_name"
        case lastName = "last_name"
    }
}

