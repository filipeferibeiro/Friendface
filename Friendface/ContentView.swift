//
//  ContentView.swift
//  Friendface
//
//  Created by Filipe Fernandes on 14/07/25.
//

import SwiftUI

struct ContentView: View {
    @State private var users: [User] = []
    @State private var path: [User] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(users) { user in
                    NavigationLink(value: user) {
                        HStack {
                            Text(user.name)
                            Spacer()
                            ActiveIndicatorView(isActive: user.isActive)
                        }
                    }
                }
            }
            .navigationTitle("Friendface")
            .navigationDestination(for: User.self, destination: { user in
                UserDetailView(user: user, users: $users)
            })
            .task {
                await getUsers()
            }
        }
    }
    
    func getUsers() async {
        if users.isEmpty == false { return }

        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            if let decodedData = try? decoder.decode([User].self, from: data) {
                users = decodedData
            }
        } catch {
            print("Failed to load users.")
        }
    }
}

#Preview {
    ContentView()
}
