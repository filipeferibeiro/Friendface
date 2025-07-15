//
//  ActiveIndicatorView.swift
//  Friendface
//
//  Created by Filipe Fernandes on 14/07/25.
//

import SwiftUI

struct ActiveIndicatorView: View {
    var isActive: Bool
    
    var body: some View {
        Text(isActive ? "Active" : "Offline")
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(isActive ? .green : .red)
            .foregroundStyle(.white)
            .font(.caption.bold())
            .clipShape(.capsule)
    }
}

#Preview {
    ActiveIndicatorView(isActive: true)
}
