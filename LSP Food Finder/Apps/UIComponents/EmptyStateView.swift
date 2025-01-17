//
//  EmptyStateView.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 09/01/25.
//

import SwiftUI

struct EmptyStateView: View {
    let message: String
    var body: some View {
        VStack {
            Text(message)
                .font(.system(size: 25, weight: .bold, design: .rounded))
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    EmptyStateView(message: "Maaf Data Kosong")
}
