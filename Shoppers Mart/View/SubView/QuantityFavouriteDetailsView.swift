//
//  QuantityFavouriteDetailsView.swift
//  Shoppers Mart
//
//  Created by Md Abir Hossain on 09-06-2023.
//

import SwiftUI

struct QuantityFavouriteDetailView: View {
    // MARK: - PROPERTY
    
    @Binding var counter: Int
    
    // MARK: - BODY
    
    var body: some View {
        HStack(alignment: .center, spacing: 6, content: {
            Button(action: {
                if counter > 1 {
                    counter -= 1
                }
            }, label: {
                Image(systemName: "minus.circle")
            })
            
            Text("\(counter)")
                .fontWeight(.semibold)
                .frame(minWidth: 36)
            
            Button(action: {
                if counter < 100 {
                    counter += 1
                }
            }, label: {
                Image(systemName: "plus.circle")
            })
            
            Spacer()
            
            Button(action: {
            }, label: {
                Image(systemName: "heart.circle")
                    .foregroundColor(.pink)
            })
        }) //: HSTACK
        .font(.system(.title, design: .rounded))
        .foregroundColor(.black)
        .imageScale(.large)
    }
}

// MARK: - PREVIEW

struct QuantityFavouriteDetailView_Previews: PreviewProvider {
    @State static var counter: Int = 1
    static var previews: some View {
        QuantityFavouriteDetailView(counter: $counter)
    }
}
