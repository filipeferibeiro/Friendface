//
//  UserDetailView.swift
//  Friendface
//
//  Created by Filipe Fernandes on 14/07/25.
//

import SwiftUI

struct UserInfo<Content: View>: View {
    var title: String
    let content: () -> Content
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            content()
        }
    }
    
    init(title: String, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.content = content
    }
}

extension UserInfo where Content == Text {
    init(title: String, info: String) {
        self.init(title: title) {
            Text(info)
                .font(.callout.bold())
        }
    }
}

struct UserDetailView: View {
    var user: User
    @Binding var users: [User]
    
    var body: some View {
        List {
            Section("User info") {
                UserInfo(title: "Active") {
                    ActiveIndicatorView(isActive: user.isActive)
                }
                UserInfo(title: "Age", info: String(user.age))
                UserInfo(title: "Email", info: user.email)
                UserInfo(title: "Company", info: user.company)
                UserInfo(title: "Address", info: user.address)
            }
            
            Section("Registred") {
                UserInfo(title: "Sinse", info: user.registered.formatted(date: .abbreviated, time: .omitted))
            }
            
            Section("About") {
                Text(user.about)
            }
            
            Section("Tags") {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(user.tags, id: \.self) { tag in
                            Text(tag)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(.blue)
                                .foregroundStyle(.white)
                                .clipShape(.capsule)
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
            
            Section("Friends") {
                ForEach(user.friends, id: \.id) { friend in
                    let userFounded = friendUser(friend: friend)
                    NavigationLink(value: userFounded) {
                        HStack {
                            Text(friend.name)
                            Spacer()
                            ActiveIndicatorView(isActive: userFounded?.isActive ?? false)
                        }
                    }
                }
            }
        }
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func friendUser(friend: Friend) -> User? {
        let user = users.first(where: { $0.id == friend.id })

        return user
    }
}

#Preview {
    NavigationStack {
        UserDetailView(
            user: User(
                id: UUID(),
                isActive: true,
                name: "TestName",
                age: 21,
                company: "Someone's Company",
                email: "test@test.com",
                address: "Somewhere Street, 456",
                about: "This is a test user, the about section is to test propose and will not be aplied to the real app",
                registered: .now,
                tags: ["test", "user", "hello", "world", "hello", "world", "hello", "world"],
                friends: [
                    Friend(id: UUID(), name: "My First Friend"),
                    Friend(id: UUID(), name: "My Second Friend")
                ]
            ),
            users: .constant([])
        )
    }
}
