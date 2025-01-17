//
//  DeleteMenuView.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 11/01/25.
//

import SwiftUI

struct DeleteMenuView: View {
    let action: () -> Void
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            ButtonHorizontalFullScreenView(backgorundColor: .yellow, buttonTitle: "Hapus", isEnabled: true) {
                action()
                dismiss()
            }
        }
        .padding()
    }
}

