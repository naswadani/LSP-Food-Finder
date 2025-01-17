//
//  MenuListItemView.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 09/01/25.
//

import SwiftUI

struct MenuListItemView: View {
    let data: MenuDetailResponseModel
    var body: some View {
        HStack(spacing: 20) {
            ImageLoaderView(paddingButton: 0, imageURL: data.imageURL, sizeFont: 20)
                .frame(width: 100, height: 100)
                .cornerRadius(10)
                .clipped()
            VStack(alignment: .leading, spacing: 5) {
                Text(data.name)
                    .font(.system(size: 25, weight: .semibold, design: .rounded))
                    .lineLimit(1)
                Text(data.description)
                    .font(.system(size: 18, weight: .regular, design: .rounded))
                    .lineLimit(1)
                Text("\(data.price)")
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 120)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("yellowColor"))
        )
    }
}
