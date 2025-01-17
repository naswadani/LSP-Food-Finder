//
//  TabBarView.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 08/01/25.
//

import SwiftUI

struct TabBarView: View {
    @State var selectedTab: Int = 0
    
    var body: some View {
        ZStack {
            VStack {
                TabView(selection: $selectedTab) {
                    NavigationView {
                        HomeView(viewModel: HomeViewModel(repository: HomeRepository(homeDataHandler: HomeDataHandler())))
                    }
                    .tag(0)
                    .preferredColorScheme(.light)
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                    
                    NavigationView {
                        ProfileView(viewModel: ProfileViewModel(repository: ProfileRepository(profileDataHandler: ProfileDataHandler())))
                    }
                    .tag(1)
                    .preferredColorScheme(.light)
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
        .preferredColorScheme(.light)
    }
}

#Preview {
    TabBarView()
}
