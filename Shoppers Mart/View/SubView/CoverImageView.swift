//
//  CoverImageView.swift
//  Shoppers Mart
//
//  Created by Md Abir Hossain on 06-06-2023.
//

import SwiftUI

struct CoverImageView: View {
    // MARK: - PROPERTIES
    
    let images: [String] = ["offer1", "offer2", "offer3"]
    
    // MARK: - BODY
    
    var body: some View {
        TabView {
            ForEach(0 ..< images.count, id: \.self) { item in
                Image(images[item])
                    .resizable()
                    .scaledToFit()
                    .frame(width: 350, height: 350)
            } //: FOREACH LOOP
        } //: TAB
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

// MARK: - PREVIEW

struct CoverImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoverImageView()
    }
}
