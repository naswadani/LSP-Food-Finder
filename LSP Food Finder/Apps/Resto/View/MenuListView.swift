//
//  MenuListView.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 09/01/25.
//

import SwiftUI

struct MenuListView: View {
    @StateObject var viewModel: MenuListViewModel
    let resto: RestoDetailResponseModel
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                ImageLoaderView(paddingButton: 0, imageURL: resto.imageURL, sizeFont: 25)
                    .frame(maxWidth: .infinity)
                    .frame(height: 250)
                    .cornerRadius(10)
                    .padding(.bottom, 30)
                    .padding(.horizontal)
                
                switch viewModel.state {
                case .idle:
                    VStack(spacing: 20) {
                        ForEach(viewModel.menuList, id: \.id) { menu in
                            MenuListItemView(data: menu)
                        }
                    }
                    .padding(.horizontal)
                case .loading:
                    LoadingView()
                        .transition(.opacity)
                        .zIndex(1)
                case .empty(let message):
                    EmptyStateView(message: message)
                case .error(let error):
                    ErrorStateView(message: error) {
                        viewModel.refresh()
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchMenuList()
        }
        .refreshable {
            viewModel.refresh()
        }
    }
}

