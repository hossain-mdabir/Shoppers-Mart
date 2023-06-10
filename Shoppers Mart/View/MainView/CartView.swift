//
//  CartView.swift
//  Shoppers Mart
//
//  Created by Md Abir Hossain on 09-06-2023.
//

import SwiftUI

struct CartView: View {
    // MARK: - PROPERTIES
    
    @State private var counter: Int = 1
    
    @State private var prodDatas : [ProductList] = []
    
    // Get data from DB to show in screen or refresh screen
    private func getCustMainProductData() {
        self.prodDatas.removeAll()
        
        let prodList: [ProductList] = ProductDB().getProducts()
        
        for prod in prodList {
            self.prodDatas.append(prod)
        }
        print("\(prodDatas.count)--aaaab")
    }
    
    // MARK: - BODY
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(0 ..< 5, id: \.self) { index in
                Text("Hello")
//                HStack {
//                    AsyncImage(url: URL(string: "\(prodDatas[index].image ?? "")")) { image in
//                        image.resizable()
//                            .resizable()
//                            .frame(width: 60, height: 60)
//                    } placeholder: {
//                        ProgressView()
//                            .frame(width: 60, height: 60)
//                    }
//
//                    VStack(alignment: .leading) {
//                        Text(prodDatas[index].title ?? "")
//
//                        Text(prodDatas[index].description ?? "")
//                            .lineLimit(1)
//
//                        HStack {
//                            Button(action: {
//                                if counter > 1 {
//                                    counter -= 1
//                                    let totalPrice = ((prodDatas[index].price ?? 0.0) * Double(counter))
//                                    ProductDB().updateProd(prodTitle: prodDatas[index].title ?? "", prodQty: counter, totalPrice: totalPrice)
//                                }
//                            }, label: {
//                                Image(systemName: "minus.circle")
//                            })
//
//                            Text("\(counter)")
//                                .fontWeight(.semibold)
//                                .frame(minWidth: 36)
//
//                            Button(action: {
//                                if counter < 100 {
//                                    counter += 1
//                                    let totalPrice = ((prodDatas[index].price ?? 0.0) * Double(counter))
//                                    ProductDB().updateProd(prodTitle: prodDatas[index].title ?? "", prodQty: counter, totalPrice: totalPrice)
//                                }
//                            }, label: {
//                                Image(systemName: "plus.circle")
//                            })
//
//                            Spacer()
//
//                            Text("Price: \(prodDatas[index].totalPrice ?? 0.0, specifier: "%.2f")")
//                                .foregroundColor(Color.blue.opacity(0.7))
//                        } //: HSTACK
//                    } // VSTACK
//                    .foregroundColor(Color.black.opacity(0.5))
//                } //: HSTACK
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding()
//                .background(Color.red.opacity(0.1))
//                .cornerRadius(5)
//                .shadow(color: Color.black.opacity(0.5), radius: 5, x: 5, y: 5)
//                .shadow(color: Color.white, radius: 5, x: -1, y: -3)
//                .padding(10)
            } //: LOOP
            Spacer()
        } //: VSTACK
        .navigationTitle("Cart")
//        onAppear(perform: {
//            getCustMainProductData()
//        })
    }
}

    // MARK: - PREVIEW
struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
