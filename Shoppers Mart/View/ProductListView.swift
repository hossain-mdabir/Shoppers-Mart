//
//  ProductListView.swift
//  Shoppers Mart
//
//  Created by Md Abir Hossain on 07-06-2023.
//

import SwiftUI

struct ProductListView: View {
    // MARK: - PROPERTIES
    let apiStr: String
    @State private var prodList: [ProductList] = []
    
    // MARK: - BODY

    var body: some View {
        ScrollView {
            VStack {
                ForEach(0 ..< prodList.count, id: \.self) { index in
                    ProductView(product: prodList[index])
                } //: LOOP
            } // VSTACK
        } //: SCROLL
        .navigationTitle("Product List")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: {
            print(apiStr)
            getProducts(apiStr: apiStr) { (response, err )in
                if response != nil {
                    for list in response ?? [] {
                        prodList.append(list)
                    }
                    print("Prod List: \(prodList)")
                }
            }
        })
    }
}

// MARK: - PREVIEW

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView(apiStr: "")
    }
}
