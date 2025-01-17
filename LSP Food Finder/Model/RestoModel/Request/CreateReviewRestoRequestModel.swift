//
//  CreateReviewRestoRequestModel.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 11/01/25.
//

import Foundation

struct CreateReviewRestoRequestModel: Codable {
    var restaurantID, userID: Int
    var rating: Int
    var comment: String

    enum CodingKeys: String, CodingKey {
        case restaurantID = "restaurant_id"
        case userID = "user_id"
        case rating, comment
    }
}
