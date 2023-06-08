//
//  HomeView.swift
//  Shoppers Mart
//
//  Created by Md Abir Hossain on 06-06-2023.
//

import SwiftUI

struct HomeView: View {
    // MARK: - PROPERTIES
    
    @State private var prodList: [ProductList] = []
    
    
    // MARK: - BODY
    
    var body: some View {
        VStack {
            ScrollView {
                CoverImageView()
                    .frame(height: 300)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                
                ProductCategoryView()
                
                VStack(spacing: 0) {
                    ForEach(0 ..< prodList.count, id: \.self) { index in
                        ProductView(product: prodList[index])
                    } //: LOOP
                } // VSTACK
            } //: SCROLL
        } //: VSTACK
        .navigationTitle("Home")
        .onAppear(perform: {
            getProducts(apiStr: "products") { (response, err )in
                if response != nil {
                    prodList = response ?? []
                    print("Prod List: \(prodList)")
                }
            }
        })
    }
}

// MARK: - PREVIEW
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
