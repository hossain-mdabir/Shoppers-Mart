//
//  MainView.swift
//  Shoppers Mart
//
//  Created by Md Abir Hossain on 06-06-2023.
//

import SwiftUI

enum SelectedView {
    case home, productList, cart, profile
}

struct MainView: View {
    // MARK: - PROPERTIES
    
    
    // View Selection
    @State private var selectedView: SelectedView? = .home
    
    
    // MARK: - BODY
    
    var body: some View {
        ZStack {
            VStack {
                switch selectedView {
                    case .home:
                       HomeView()
                    case .productList:
                        ProductListView(apiStr: "products")
                    case .cart:
                        CartView()
                    case .profile:
                        ProfileView()
                    case .none:
                        HomeView()
                }
            }
            .overlay (
                HStack {
                    Button {
                        withAnimation(.easeOut(duration: 0.3)) {
                            selectedView = .home
                        }
                    } label: {
                        VStack(spacing: 0) {
                            Image(selectedView == .home ? "home" : "home_a")
                                .resizable()
                                .foregroundColor(Color.white)
                                .frame(width: 40, height: 40)
//                                .rotationEffect(.degrees(selectedView == .home ? -10 : 0))
                            
                            Text("Home")
                                .foregroundColor(selectedView == .home ? Color.red : Color.white)
                                .multilineTextAlignment(.center)
                        }
                    }
                    Spacer()
                    Button {
                        withAnimation(.easeOut(duration: 0.3)) {
                            selectedView = .productList
                        }
                    } label: {
                        VStack(spacing: 0) {
                            Image(selectedView == .productList ? "products" : "products_a")
                                .resizable()
                                .foregroundColor(Color.white)
                                .frame(width: 40, height: 40)
//                                .rotationEffect(.degrees(selectedView == .productList ? -10 : 0))
                            
                            Text("Products")
                                .foregroundColor(selectedView == .productList ? Color.red : Color.white)
                                .multilineTextAlignment(.center)
                        }
                    }
                    Spacer()
                    Button {
                        withAnimation(.easeOut(duration: 0.3)) {
                            selectedView = .cart
                        }
                    } label: {
                        VStack(spacing: 0) {
                            Image(selectedView == .cart ? "cart" : "cart_a")
                                .resizable()
                                .foregroundColor(Color.white)
                                .frame(width: 40, height: 40)
//                                .rotationEffect(.degrees(selectedView == .cart ? -10 : 0))
                            
                            Text("Cart")
                                .foregroundColor(selectedView == .cart ? Color.red : Color.white)
                                .multilineTextAlignment(.center)
                        }
                    }
                    Spacer()
                    Button {
                        withAnimation(.easeOut(duration: 0.3)) {
                            selectedView = .profile
                        }
                    } label: {
                        VStack(spacing: 0) {
                            Image(selectedView == .profile ? "profile" : "profile_a")
                                .resizable()
                                .foregroundColor(Color.white)
                                .frame(width: 40, height: 40)
//                                .rotationEffect(.degrees(selectedView == .profile ? -10 : 0))
                            
                            Text("Profile")
                                .foregroundColor(selectedView == .profile ? Color.red : Color.white)
                                .multilineTextAlignment(.center)
                        }
                    }
                }
                    .padding(.top, 5)
                    .padding(10)
                    .font(.system(size: 12))
                    .frame(maxWidth: .infinity)
                    .background(Color("Background"))
                    .roundedCorner(25, corners: [.topLeft, .topRight, .bottomLeft, .bottomRight])
                    .padding(.horizontal)
                , alignment: .bottom
            )
        }
        .navigationViewStyle(.stack)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


// MARK: - PROPERTIES


// MARK: - BODY

//var body: some View {
//    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//}
//}
//
// MARK: - PREVIEW
