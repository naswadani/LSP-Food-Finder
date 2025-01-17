//
//  ListMenuView.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 10/01/25.
//

import SwiftUI

struct ListMenuView: View {
    @Binding var selectedId: Int?
    @StateObject var viewModel: ListMenuViewModel
    @State private var isSheetPresented: Bool = false
    @State private var isSheetDeletePresented: Bool = false
   
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                switch viewModel.state {
                case .idle:
                    VStack(spacing: 20) {
                        ForEach(viewModel.menuList, id: \.id) { menu in                 
                            NavigationLink(destination: EditMenuView(selectedMenuId: menu.id, viewModel: viewModel)) {
                                MenuListItemView(data: menu)
                            }
                        }
                        Spacer()
                        ButtonHorizontalFullScreenView(backgorundColor: .yellow, buttonTitle: "Tambah Menu", isEnabled: true, action: {
                            isSheetPresented = true
                        })
                    }
                    .padding(.horizontal)
                case .loading:
                    LoadingView()
                        .transition(.opacity)
                        .zIndex(1)
                case .empty(let message):
                    VStack {
                        EmptyStateView(message: message)
                        Spacer()
                        ButtonHorizontalFullScreenView(backgorundColor: .yellow, buttonTitle: "Tambah Menu", isEnabled: true, action: {
                            isSheetPresented = true
                        })
                    }
                    .padding(.horizontal)
                case .error(let error):
                    ErrorStateView(message: error) {
                        viewModel.refresh()
                    }
                }
            }
        }.onAppear {
            viewModel.fetchMenuList()
        }
        .refreshable {
            viewModel.refresh()
        }
        .sheet(isPresented: $isSheetPresented) {
            CreateMenuView(action: viewModel.createMenu, request: $viewModel.requestMenu, isEnabled: true)
                .presentationDetents([.height(350)])
        }
    }
}

