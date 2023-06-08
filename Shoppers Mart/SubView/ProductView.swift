//
//  ProductView.swift
//  Shoppers Mart
//
//  Created by Md Abir Hossain on 07-06-2023.
//

import SwiftUI

struct ProductView: View {
    // MARK: - PROPERTIES
    
    let product: ProductList
    
    // MARK: - BODY
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: "\(product.image ?? "")")) { image in
                image.resizable()
                    .resizable()
                    .frame(width: 60, height: 60)
            } placeholder: {
                ProgressView()
                    .frame(width: 60, height: 60)
            }
            
            VStack(alignment: .leading) {
                Text(product.title ?? "")
                
                Text(product.description ?? "")
                    .lineLimit(1)
                
                HStack {
                    Text("\(product.rating?.rate ?? 0.0, specifier: "%.2f")")
                    Spacer()
                    Text("Price: \(product.price ?? 0.0, specifier: "%.2f")")
                        .foregroundColor(Color.blue.opacity(0.7))
                }
            }
            .foregroundColor(Color.black.opacity(0.5))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(5)
        .shadow(color: Color.black.opacity(0.5), radius: 5, x: 5, y: 5)
        .shadow(color: Color.white, radius: 5, x: -1, y: -3)
        .padding(5)
    }
}

// MARK: - PREVIEW

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView(product: ProductList())
    }
}
