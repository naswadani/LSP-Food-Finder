//
//  AddMenuReviewView.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 17/01/25.
//

import SwiftUI

struct AddMenuRatingView: View {
    let selectedMenu: Int
    @StateObject var viewModel: MenuListViewModel
    @State var showRatingAddSheet: Bool = false
    var body: some View {
        VStack(spacing: 20) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 10) {
                    ForEach(viewModel.ratingMenuList, id: \.id) { rating in
                        HStack(spacing: 0) {
                            Text(rating.user.username)
                                .font(.system(size: 20))
                            Spacer()
                            Image(systemName: "star.fill")
                                .font(.system(size: 15))
                            Text("\(rating.rating)")
                                .font(.system(size: 20))
                                .padding(.leading, 5)
                        }
                    }
                    
                   
                    ButtonHorizontalFullScreenView(backgorundColor: .yellow, buttonTitle: "Tambah Rating", isEnabled: true) {
                        showRatingAddSheet = true
                    }
                    .padding(.top, 20)
                }
                .padding()
            }
           
        }
        .onAppear {
            viewModel.fetchMenuRating(id: selectedMenu)
        }
        .sheet(isPresented: $showRatingAddSheet) {
            VStack(spacing: 20) {
                HStack {
                    Image(systemName: "star.fill")
                        .frame(width: 25, alignment: .center)
                        .font(.system(size: 20))
                        .padding(.trailing, 20)
                    TextField("Masukkan rating", text: Binding(
                        get: {
                            guard let rating = viewModel.requestCreateMenuRating.rating else { return "" }
                            return String(rating)
                        },
                        set: { newValue in
                            viewModel.requestCreateMenuRating.rating = Int(newValue)
                        }
                    ))
                }
                .padding()
                .background(
                    Group {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 1)
                            .background(Color.clear)
                    }
                )
                
                ButtonHorizontalFullScreenView(backgorundColor: .yellow, buttonTitle: "Tambahkan Rating", isEnabled: true, action: {
                    viewModel.createMenuRating(id: selectedMenu)
                    showRatingAddSheet = false
                })
            }
            .padding()
            .presentationDetents([.height(200)])
        }
    }
}
