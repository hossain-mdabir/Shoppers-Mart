//
//  ProductDetailsView.swift
//  Shoppers Mart
//
//  Created by Md Abir Hossain on 07-06-2023.
//

import SwiftUI

struct ProductDetailsView: View {
    var body: some View {
        ScrollView {
            VStack {
                TabView {
                    ForEach(0 ..< 3) { index in
                        Image("person")
                            .resizable()
                            .font(.title)
                        
                        Text("Product Name")
                        
                        Text("৳ \(Text("2542").font(.title3))")
                    }
                }
            }
        }
    }
}

struct ProductDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailsView()
    }
}
