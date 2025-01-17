//
//  UserProfileResponseModel.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 09/01/25.
//

import Foundation

struct UserProfileResponseModel: Codable {
    let id: Int
    let username, email, firstName, lastName: String
    var restaurant: RestoDetailResponseModel?

    enum CodingKeys: String, CodingKey {
        case id
        case username, email
        case firstName = "first_name"
        case lastName = "last_name"
        case restaurant
    }
}
