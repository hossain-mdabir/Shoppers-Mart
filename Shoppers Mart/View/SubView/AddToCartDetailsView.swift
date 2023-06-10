//
//  AddToCartDetailsView.swift
//  Shoppers Mart
//
//  Created by Md Abir Hossain on 09-06-2023.
//

import SwiftUI

struct AddToCartDetailView: View {
    // MARK: - PROPERTY
    
    @Binding var product: ProductList
    @Binding var counter: Int
    
    // MARK: - BODY
    
    var body: some View {
        Button(action: {
            product.orderQty = counter
            product.totalPrice = ((product.price ?? 0.0) * Double(counter))
            
            ProductDB().insertProd(prod: product)
        }, label: {
            Spacer()
            Text("Add to cart".uppercased())
                .font(.system(.title2, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(.white)
            Spacer()
        }) //: BUTTON
        .padding(15)
        .background(Color.blue.opacity(0.4))
        .clipShape(Capsule())
    }
}

// MARK: - PREVIEW

struct AddToCartDetailView_Previews: PreviewProvider {
    @State static var product = ProductList()
    @State static var counter: Int = 1
    static var previews: some View {
        AddToCartDetailView(product: $product, counter: $counter)
    }
}
