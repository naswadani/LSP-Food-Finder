//
//  SegmentedControlDetailResto.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 09/01/25.
//

import SwiftUI

struct SegmentedControlDetailResto: View {
    @State private var selectedTab = 0
    let resto: RestoDetailResponseModel
    let userId: Int
    
    var body: some View {
        VStack {
            Picker("Tabs", selection: $selectedTab) {
                Text("Menu").tag(0)
                Text("Info").tag(1)
                Text("Review").tag(2)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            if selectedTab == 0 {
                MenuListView(viewModel: MenuListViewModel(repository: RestoRepository(restoDataHandler: RestoDataHandler()), selectedRestoId: resto.id, userId: userId), resto: resto)
            } else if selectedTab == 1 {
                RestoInfoView(resto: resto)
            } else if selectedTab == 2 {
                RestoReviewList(viewModel: MenuListViewModel(repository: RestoRepository(restoDataHandler: RestoDataHandler()), selectedRestoId: resto.id, userId: userId), resto: resto)
            }
        }
    }
}

