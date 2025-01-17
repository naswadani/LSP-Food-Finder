//
//  MenuRatingResponseModel.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 17/01/25.
//

import Foundation


struct MenuRatingResponseModel: Codable {
    let id: Int
    let user: UserProfileResponseModel
    let menu: MenuDetailResponseModel
    let rating: Int
    let createdAt, updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id, user, menu, rating
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
