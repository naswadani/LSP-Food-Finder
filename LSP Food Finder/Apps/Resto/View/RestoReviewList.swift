//
//  RestoReviewList.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 11/01/25.
//

import SwiftUI

struct RestoReviewList: View {
    @StateObject var viewModel: MenuListViewModel
    @State private var isCreateReviewSheetPresented: Bool = false
    @State private var isEditReviewSheetPresented: Bool = false
    @State private var isDeleteSheetPresented: Bool = false
    let resto: RestoDetailResponseModel
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                ImageLoaderView(paddingButton: 0, imageURL: resto.imageURL, sizeFont: 25)
                    .frame(maxWidth: .infinity)
                    .frame(height: 250)
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                    .cornerRadius(10)
                    .padding(.bottom, 30)
                
                Text("List Review")
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                
                VStack(spacing: 20) {
                    ForEach(viewModel.reviewList, id: \.id) { menu in
                        if menu.user.id == viewModel.userId {
                            RestoReviewListItemView(data: menu, myResto: true, action: {
                                viewModel.selectID(menu.id)
                                isEditReviewSheetPresented = true
                            }, action2: {
                                viewModel.selectID(menu.id)
                                isDeleteSheetPresented = true
                            }  )
                        } else {
                            RestoReviewListItemView(data: menu, myResto: false, action: {}, action2: {})

                        }
                    }
                }
                
                ButtonHorizontalFullScreenView(backgorundColor: .yellow, buttonTitle: "Tambahkan Review", isEnabled: true, action: {
                    isCreateReviewSheetPresented = true
                })
            }
            .padding(.horizontal)
        }
        .onAppear {
            viewModel.fetchRestoReview()
        }
        .refreshable {
            viewModel.refreshReview()
        }
        .sheet(isPresented: $isCreateReviewSheetPresented) {
            CreateReviewRestoView(action: {
                viewModel.createReview()
            }, request: $viewModel.requestCreateReview)
            .presentationDetents([.height(350)])
        }
        .sheet(isPresented: $isEditReviewSheetPresented) {
            CreateReviewRestoView(action: {
                viewModel.updateReview()
            }, request: $viewModel.requestCreateReview)
            .presentationDetents([.height(350)])
        }
        
        .sheet(isPresented: $isDeleteSheetPresented) {
            DeleteMenuView(action: {
                viewModel.deleteReview()
            })
            .presentationDetents([.height(150)])
        }
    }
}

