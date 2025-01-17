//
//  UserRegisterResponseModel.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 06/01/25.
//

import Foundation

struct UserRegisterResponseModel: Codable {
    let username, email, firstName, lastName: String
    let restaurant: RestoDetailResponseModel?

    enum CodingKeys: String, CodingKey {
        case username, email
        case firstName = "first_name"
        case lastName = "last_name"
        case restaurant
    }
}


