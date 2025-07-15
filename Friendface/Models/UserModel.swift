//
//  UserModel.swift
//  Friendface
//
//  Created by Filipe Fernandes on 14/07/25.
//

import Foundation

struct User: Codable, Identifiable, Hashable, Equatable {
    var id: UUID
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
}
