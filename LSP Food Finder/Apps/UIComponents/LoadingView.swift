//
//  LoadingView.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 07/01/25.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(DefaultProgressViewStyle())
            .scaleEffect(1)
    }
}

#Preview {
    LoadingView()
}
