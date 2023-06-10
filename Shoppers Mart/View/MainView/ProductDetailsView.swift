//
//  ProductDetailsView.swift
//  Shoppers Mart
//
//  Created by Md Abir Hossain on 07-06-2023.
//

import SwiftUI

struct ProductDetailsView: View {
    // MARK: - PROPERTIES
    
    @Binding var product: ProductList
    
    @State private var counter: Int = 1
    
    
    // MARK: - BODY
    
    var body: some View {
//        ScrollView {
            VStack(spacing: 20) {
                AsyncImage(url: URL(string: "\(product.image ?? "")")) { image in
                    image.resizable()
                        .resizable()
                        .frame(maxWidth: .infinity, maxHeight: 200)
                        .padding(.horizontal)
                } placeholder: {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: 200)
                        .padding(.horizontal)
                }
                
                VStack(alignment: .leading) {
                    Text("\(product.title ?? "")")
                        .fontWeight(.semibold)
                    
                    HStack {
                        Image(systemName: "star.fill")
                            .font(.title2.weight(.semibold))
                            .foregroundColor(Color.yellow)
                        
                        Text("\(product.rating?.rate ?? 0.0, specifier: "%.1f")/5 (\(product.rating?.count ?? 0))")
                    } //: HSTACK
                    .foregroundColor(Color.gray)
                    
                    Text("৳ \(Text("\(((product.price ?? 0.0) * Double(counter)), specifier: "%.2f")").font(.title3).foregroundColor(Color.red))")
                    
                    ScrollView(showsIndicators: false) {
                            Text("\(product.description ?? "")")
                            .foregroundColor(Color.gray)
                    } //: SCROLL
                    
                    // QUANTITY + FAVOURITE
                    QuantityFavouriteDetailView(counter: $counter)
                        .padding(.vertical, 10)
                    
                    // ADD TO CART
                    AddToCartDetailView(product: $product, counter: $counter)
                        .padding(.bottom, 20)
                } //: VSTACK
                .frame(maxWidth: .infinity, alignment: .leading)
            } //: VSTACK
            .padding()
//        } //: SCROLL
    }
}

struct ProductDetailsView_Previews: PreviewProvider {
    @State static var product  = ProductList()
    static var previews: some View {
        ProductDetailsView(product: $product)
    }
}
