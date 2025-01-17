//
//  CreateRestoRequestModel.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 10/01/25.
//

import Foundation

struct EditRestoRequestModel: Codable {
    var name: String
    var description, address, phone, website: String
    var lattitude, longitude: Double
}
