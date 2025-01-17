//
//  CreateMenuRequestModel.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 10/01/25.
//

import Foundation

struct CreateMenuRequestModel: Codable {
    var restaurantId: Int
    var name: String
    var description: String
    var price: Double
    
    enum CodingKeys: String, CodingKey {
        case restaurantId = "restaurant_id"
        case name
        case description
        case price
    }
}
