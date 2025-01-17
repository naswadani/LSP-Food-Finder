//
//  MenuDetailResponseModel.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 06/01/25.
//

import Foundation

struct MenuDetailResponseModel : Codable {
    let id, restaurant: Int
    let name, description: String
    let price: String
    let image: String?
    let createdAt, updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id, restaurant, name, description, price, image
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    var imageURL: String? {
        guard let imagePath = image else { return nil }
        return APIConfig.baseURL + imagePath
    }
    
    
    var formattedPrice: String {
        return price.replacingOccurrences(of: ".00", with: "")
    }
}

