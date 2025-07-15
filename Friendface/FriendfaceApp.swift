//
//  FriendfaceApp.swift
//  Friendface
//
//  Created by Filipe Fernandes on 14/07/25.
//

import SwiftUI

@main
struct FriendfaceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
