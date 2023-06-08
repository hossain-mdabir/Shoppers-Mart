//
//  CoverImageView.swift
//  Shoppers Mart
//
//  Created by Md Abir Hossain on 06-06-2023.
//

import SwiftUI

struct CoverImageView: View {
    // MARK: - PROPERTIES
    
    let images: [String] = ["person", "person", "person", "person", "person", "person"]
    
    // MARK: - BODY
    
    var body: some View {
        TabView {
            ForEach(0 ..< images.count, id: \.self) { item in
                Image(systemName: images[item])
                    .resizable()
                    .frame(width: 350, height: 350)
                    .scaledToFill()
            } //: FOREACH LOOP
        } //: TAB
        .tabViewStyle(PageTabViewStyle())
    }
}

// MARK: - PREVIEW

struct CoverImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoverImageView()
    }
}
