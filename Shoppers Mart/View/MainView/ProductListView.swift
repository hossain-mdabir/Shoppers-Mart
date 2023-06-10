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
    
//    let gridColumns = [
//        GridItem(.adaptive(minimum: 60))
//    ]
    
    // MARK: - BODY

    var body: some View {
        ZStack {
            Color.gray.opacity(0.3)
                .ignoresSafeArea(.all, edges: [.bottom, .horizontal, .bottom,])
            
            ScrollView(showsIndicators: false) {
                    LazyVStack {
                        ForEach(0 ..< prodList.count, id: \.self) { index in
                            //                        ProductView(product: prodList[index])
                            NavigationLink(destination: ProductDetailsView(product: $prodList[index])) {
                                VStack {
                                    AsyncImage(url: URL(string: "\(prodList[index].image ?? "")")) { image in
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
                                        Text("\(prodList[index].title ?? "")")
                                            .lineLimit(1)
                                        
                                        HStack {
                                            Image(systemName: "star.fill")
                                                .font(.title3)
                                                .foregroundColor(Color.yellow)
                                            
                                            Text("\(prodList[index].rating?.rate ?? 0.0, specifier: "%.1f")/5 (\(prodList[index].rating?.count ?? 0))")
                                        }
                                        .foregroundColor(Color.gray)
                                        
                                        Text("৳ \(Text("\(prodList[index].price ?? 0.0, specifier: "%.2f")").font(.title3).foregroundColor(Color.red))")
                                    } //: VSTACK
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                } //: VSTACK
                                .padding(5)
                                .background(Color.white)
                                .cornerRadius(10)
                            }
                        } //: LOOP
                    } // LAZY-VSTACK
                    .padding()
            } //: SCROLL
        }
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
