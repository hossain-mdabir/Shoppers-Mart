//
//  ProductCategoryView.swift
//  Shoppers Mart
//
//  Created by Md Abir Hossain on 06-06-2023.
//

import SwiftUI

struct ProductCategoryView: View {
    // MARK: - PROPERTIES
    
    @State private var prodCat: [String] = []
    
    let gridColumns = [
        GridItem(.adaptive(minimum: 150))
        ]

    // MARK: - BODY

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: gridColumns , spacing: 20) {
                ForEach(0 ..< prodCat.count, id: \.self) { item in
                    NavigationLink(destination: ProductListView(apiStr: "products/category/\(prodCat[item].replacingOccurrences(of: " ", with: "%20", options: NSString.CompareOptions.literal, range: nil))")) {
                        VStack(spacing: 0) {
                            Image(prodCat[item])
                                .resizable()
                                .frame(width: 50, height: 50)
                            Text(prodCat[item])
                                .foregroundColor(Color.gray)
                                .frame(width: 100, height: 50)
                                .multilineTextAlignment(.center)
                        } //: VSTACK
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                    }
                } //: LOOP
            } //: LazyHGrid
        } //: SCROLL
        .padding(.horizontal)
        .onAppear(perform: {
            getProductCategory(apiStr: "products/categories") { (response, err )in
                if response != nil {
                    prodCat = response ?? [""]
//                    for cat in response ?? [] {
//                        self.prodCat.append(cat)
//                    }
                    print("Prod Cat: \(prodCat)")
                }
            }
        }) //: ON-APPEAR
    }
}

    // MARK: - PREVIEW

struct ProductCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCategoryView()
    }
}
