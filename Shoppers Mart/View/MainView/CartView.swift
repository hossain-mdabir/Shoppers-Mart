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
        
        if prodDatas.count == 0 {
            for prod in prodList {
                self.prodDatas.append(prod)
            }
        }
        print("\(prodDatas.count)--aaaab")
    }
    
    // MARK: - BODY
    
    var body: some View {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    if prodDatas.count > 0 {
                        ForEach(0 ..< prodDatas.count, id: \.self) { index in
                            HStack {
                                AsyncImage(url: URL(string: "\(prodDatas[index].image ?? "")")) { image in
                                    image.resizable()
                                        .resizable()
                                        .frame(width: 60, height: 60)
                                        .padding(.leading, 3)
                                } placeholder: {
                                    ProgressView()
                                        .frame(width: 60, height: 60)
                                }
                                
                                VStack(alignment: .leading) {
                                    Text(prodDatas[index].title ?? "")
                                    
                                    Text(prodDatas[index].description ?? "")
                                        .lineLimit(1)
                                    
                                    HStack {
                                        Button(action: {
                                            if prodDatas[index].orderQty ?? 0 > 1 {
                                                //                                            prodDatas[index].orderQty ?? 0 = ((prodDatas[index].orderQty ?? 0) - 1)
                                                let totalPrice = ((prodDatas[index].price ?? 0.0) * Double((prodDatas[index].orderQty ?? 0) - 1))
                                                ProductDB().updateProd(prodTitle:
                                                                        prodDatas[index].title ?? "", prodQty: ((prodDatas[index].orderQty ?? 0) - 1), totalPrice: totalPrice)
                                                getCustMainProductData()
                                            }
                                        }, label: {
                                            Image(systemName: "minus.circle")
                                        })
                                        
                                        Text("\(prodDatas[index].orderQty ?? 0)")
                                            .fontWeight(.semibold)
                                            .frame(minWidth: 36)
                                        
                                        Button(action: {
                                            if prodDatas[index].orderQty ?? 0 < 100 {
                                                //                                            prodDatas[index].orderQty ?? 0 = ((prodDatas[index].orderQty ?? 0) + 1)
                                                let totalPrice = ((prodDatas[index].price ?? 0.0) * Double((prodDatas[index].orderQty ?? 0) + 1))
                                                ProductDB().updateProd(prodTitle: prodDatas[index].title ?? "", prodQty: ((prodDatas[index].orderQty ?? 0) + 1), totalPrice: totalPrice)
                                                getCustMainProductData()
                                            }
                                        }, label: {
                                            Image(systemName: "plus.circle")
                                        })
                                        
                                        Spacer()
                                        
                                        Button {
                                            ProductDB().deleteProd(prodTitle: prodDatas[index].title ?? "")
                                            getCustMainProductData()
                                        } label: {
                                            Image(systemName: "trash")
                                                .foregroundColor(Color.red)
                                        }
                                        
                                    } //: HSTACK
                                    
                                    HStack {
                                        Spacer()
                                        Text("Price: \(prodDatas[index].totalPrice ?? 0.0, specifier: "%.2f")")
                                            .foregroundColor(Color.blue.opacity(0.7))
                                    }
                                } // VSTACK
                                .foregroundColor(Color.black.opacity(0.5))
                            } //: HSTACK
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(Color.red.opacity(0.1))
                            .cornerRadius(5)
                            .shadow(color: Color.black.opacity(0.5), radius: 5, x: 5, y: 5)
                            .shadow(color: Color.white, radius: 5, x: -1, y: -3)
                            .padding(10)
                        } //: LOOP
                    } else {
                        Text("Your cart is Empty!!")
                            .padding(.top, 50)
                            .font(.title.weight(.bold))
                            .foregroundColor(Color.red)
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                    }
                    
                    Spacer()
                } //: VSTACK
                .navigationTitle("Cart")
                .onAppear(perform: {
                    getCustMainProductData()
                })
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        if prodDatas.count > 0 {
                            Button {
                                
                            } label: {
                                Image(systemName: "paperplane.fill")
                                    .foregroundColor(Color.primary)
                            }
                        }
                    }
                }
            } //: SCROLL
    }
}

    // MARK: - PREVIEW
struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
