//
//  ReviewResponseModel.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 11/01/25.
//

import Foundation


struct ReviewResponseModel: Codable {
    let id: Int
    let restaurant: RestoDetailResponseModel
    let user: UserProfileResponseModel
    let rating: Int
    let comment, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, restaurant, user, rating, comment
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
