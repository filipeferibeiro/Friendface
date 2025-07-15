//
//  FriendModel.swift
//  Friendface
//
//  Created by Filipe Fernandes on 14/07/25.
//

import Foundation

struct Friend: Codable, Identifiable, Hashable, Equatable {
    var id: UUID
    let name: String
}
