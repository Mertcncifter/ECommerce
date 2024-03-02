//
//  ProductService.swift
//  ECommerce
//
//  Created by mert can çifter on 25.02.2024.
//

import Foundation



protocol ProductAPI {
    func fetchProducts(completion: (ProductResult) -> (Void)) -> (Void)
}

class ProductService {
    
    static let shared: ProductService = ProductService()
    
    private init() {}
    
}

extension ProductService: ProductAPI {
    
    func fetchProducts(completion: (ProductResult) -> (Void)) {
        if let url = Bundle.main.url(forResource: "product", withExtension: "json") {
            
            do {
                let data = try Data(contentsOf: url)
                
                let result = try JSONDecoder().decode(ProductResult.self, from: data)
                completion(result)
                
            } catch {
                
            }
        }
    }
}


