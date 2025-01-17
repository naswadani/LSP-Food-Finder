//
//  SegmentedControlProfileRestoView.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 10/01/25.
//

import SwiftUI

struct SegmentedControlProfileRestoView: View {
    @State private var selectedTab = 0
    @State private var selectedId: Int?
    var body: some View {
        VStack {
            Picker("Tabs", selection: $selectedTab) {
                Text("Menu").tag(0)
                Text("Info").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            if selectedTab == 0 {
                ProfileRestoView(viewModel: ProfileRestoViewModel(repository: ProfileRepository(profileDataHandler: ProfileDataHandler())), selectedId: $selectedId)
            } else if selectedTab == 1 {
                ListMenuView(selectedId: $selectedId, viewModel: ListMenuViewModel(repository: ProfileRepository(profileDataHandler: ProfileDataHandler()), selectedRestoId: selectedId))
            }
        }
    }
}
