//
//  RestoDetailResponseModel.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 06/01/25.
//

import Foundation

struct RestoDetailResponseModel: Codable {
    let id: Int
    let name: String
    let owner: Int
    let description, address, phone, website: String
    let lattitude, longitude: Double?
    let image: String?
    let createdAt, updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, owner, description, address, phone, website, lattitude, longitude, image
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    var imageURL: String? {
        guard let imagePath = image else { return nil }
        return APIConfig.baseURL + imagePath
    }
}
