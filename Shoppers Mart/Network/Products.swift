//
//  Products.swift
//  Shoppers Mart
//
//  Created by Md Abir Hossain on 08-06-2023.
//

import Foundation
import Alamofire


func getProducts(apiStr: String?, completionHandler: @escaping (([ProductList]?, Error?)->Void)) {
    
    let mainUrl = "\(Api().api)\(apiStr ?? "")"
    print("mainUrl: \(mainUrl)")
    var request = URLRequest(url: (URL(string: mainUrl))!)
    request.httpMethod = HTTPMethod.get.rawValue
    request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
    
    AF.request(request).responseData { response in
        print("request: \(request.debugDescription)")
        print("response: \(response.debugDescription)")
        switch response.result {
            case .success(let value):
                
                let response = try? JSONDecoder().decode([ProductList].self, from: value)
                
                print ("product Response: \(response)")
                print ("product value: \(value)")
                
                completionHandler(response, nil)
            case .failure(let error):
                print("Print error In: \(error)")
        }
    }
}
