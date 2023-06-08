//
//  ProductList.swift
//  Shoppers Mart
//
//  Created by Md Abir Hossain on 08-06-2023.
//

import Foundation


import Foundation

// MARK: - ProductList
struct ProductList: Decodable {
    var id: Int?
    var title: String?
    var price: Double?
    var description: String?
    var category: String?
    var image: String?
    var rating: Rating?
}

// MARK: - Rating
struct Rating: Decodable {
    var rate: Double?
    var count: Int?
}
