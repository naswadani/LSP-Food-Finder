//
//  HomeView.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 08/01/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    @State var textInputValue: String = ""
    var body: some View {
        ZStack {
            switch viewModel.state {
            case .idle:
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 15) {
                        TextInputComponentView(
                            instruction: "Find Resto",
                            icon: "magnifyingglass",
                            value: $textInputValue,
                            useWhiteBackground: false
                        )
                        .onChange(of: textInputValue) { newValue in
                            viewModel.filterResto(by: newValue)
                        }
                        
                        ForEach(viewModel.filteredRestoList, id: \.id) { resto in
                            NavigationLink(destination: SegmentedControlDetailResto(resto: resto, userId: viewModel.idUser?.id ?? 0)) {
                                ListRestoItemView(data: resto)
                            }
                        }
                    }
                    .padding()
                }
            case .loading:
                Color.black.opacity(0.5).ignoresSafeArea(.all)
                LoadingView()
                    .transition(.opacity)
                    .zIndex(1)
            case .empty(let message):
                EmptyStateView(message: message)
            case .error(let error):
                ErrorStateView(message: error, action: {
                    viewModel.refresh()
                })
            }
        }
        .onAppear {
            viewModel.fetchResto()
            viewModel.fetchProfileData()
        }
        .refreshable {
            viewModel.refresh()
        }
        .navigationBarBackButtonHidden()
        .navigationTitle("Restaurants")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(destination: LoginView(viewModel: AuthViewModel(repository: AuthRepository(authDataHandler: AuthDataHandler())))) {
                    Image(systemName: "door.right.hand.open")
                        .font(.system(size: 20))
                        .foregroundColor(.red)
                }
            }
        }
    }
}
