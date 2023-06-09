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
    
    @EnvironmentObject var profileImage: ImageViewModel
    
    // MARK: - BODY
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                CoverImageView()
                    .frame(height: 300)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                
                ProductCategoryView()
                
                VStack(spacing: 0) {
                    ForEach(0 ..< prodList.count, id: \.self) { index in
                        NavigationLink(destination: ProductDetailsView(product: prodList[index])) {
                            ProductView(product: prodList[index])
                        }
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
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
//                Image(uiImage: (profileImage.image ?? UIImage(systemName: "profile_a"))!)
                if let image = profileImage.image {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 40, height: 40)
                        .cornerRadius(80)
                } else {
                    Image(systemName: "person.fill")
                        .font(.system(size: 18))
                        .padding()
                        .foregroundColor(Color(.label))
                }
            }
        }
    }
}

// MARK: - PREVIEW
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
