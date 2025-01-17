//
//  RestoListItemView.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 11/01/25.
//

import SwiftUI

struct RestoReviewListItemView: View {
    let data: ReviewResponseModel
    let myResto: Bool
    let action: () -> Void?
    let action2: () -> Void?
    
    var body: some View {
        HStack(alignment: .center) {
            if myResto {
                Button(action: {
                    action2()
                }) {
                    Image(systemName: "trash.fill")
                        .font(.system(size: 25))
                        .foregroundColor(.red)
                }
            }
            Image(systemName: "person.fill")
                .font(.system(size: 20))
                .padding()
            Spacer()
            VStack(alignment: .leading) {
                Text("\(data.user.firstName + " " + data.user.lastName)")
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                Text("\(data.comment)")
                    .font(.system(size: 15, weight: .light, design: .rounded))
                    .lineLimit(1)
            }
            Spacer()
            
            Text("\(data.rating)")
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .padding(.leading)
            
            Image(systemName: "star.fill")
                .font(.system(size: 20))
            
            if myResto {
                Button(action: {
                    action()
                }) {
                    Image(systemName: "arrow.right.to.line.circle.fill")
                        .font(.system(size: 25))
                }
            }
               
        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(height: 75)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.yellow)
        )
    }
}

