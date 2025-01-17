//
//  ImageLoaderView.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 09/01/25.
//

import SwiftUI

struct ImageLoaderView: View {
    let paddingButton: CGFloat
    let imageURL: String?
    let sizeFont: CGFloat
    
    var body: some View {
        Group {
            if imageURL == nil || imageURL!.isEmpty {
                Image(systemName: "photo.on.rectangle")
                    .font(.system(size: sizeFont))
                    .foregroundColor(.gray)
                    .padding(.bottom, paddingButton)
            } else {
                AsyncImage(url: URL(string: imageURL ?? "")) { phase in
                    switch phase {
                    case .empty:
                        ZStack {
                            Color.white.ignoresSafeArea(.all)
                            ProgressView()
                                .foregroundColor(.gray)
                                .padding(.bottom, paddingButton)
                        }
                    case .success(let image):
                        GeometryReader { geometry in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .clipped()
                        }
                    case .failure:
                        Image(systemName: "photo.on.rectangle")
                            .font(.system(size: sizeFont))
                            .foregroundColor(.gray)
                            .padding(.bottom, paddingButton)
                    @unknown default:
                        EmptyView()
                    }
                }
            }
        }
    }
}
