//
//  ProductCategory.swift
//  Shoppers Mart
//
//  Created by Md Abir Hossain on 08-06-2023.
//

import Foundation
import Alamofire


func getProductCategory(apiStr: String?, completionHandler: @escaping (([String]?, Error?)->Void)) {
    
    let mainUrl = "\(Api().api)\(apiStr ?? "")"
    
    var request = URLRequest(url: URL(string: mainUrl)!)
    request.httpMethod = HTTPMethod.get.rawValue
    request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
    
    AF.request(request).responseData { response in
        switch response.result {
            case .success(let value):
                
                let response = try? JSONDecoder().decode([String].self, from: value)
                
                print ("product Response: \(response)")
                
                completionHandler(response, nil)
            case .failure(let error):
                print("Print error In: \(error)")
        }
    }
}
