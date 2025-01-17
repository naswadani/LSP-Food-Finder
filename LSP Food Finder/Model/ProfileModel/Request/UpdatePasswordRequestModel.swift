//
//  UpdatePasswordRequestModel.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 09/01/25.
//

import Foundation

struct UpdatePasswordRequestModel: Codable {
    var oldPassword: String
    var newPassword: String
    var confirmation: String
    
    enum CodingKeys: String, CodingKey {
        case oldPassword = "old_password"
        case newPassword = "new_password"
        case confirmation
    }
}
