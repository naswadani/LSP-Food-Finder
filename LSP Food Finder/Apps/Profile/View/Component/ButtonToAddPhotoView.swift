//
//  ButtonToAddPhoto.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 10/01/25.
//

import SwiftUI

struct ButtonToAddPhotoView: View {
    let action: () -> Void
    let label: String
    var body: some View {
        Button(action: {
            action()
        }) {
            Text(label)
                .foregroundColor(.black)
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.yellow)
                        .frame(width: 95, height: 55)
                )
        }
    }
}
