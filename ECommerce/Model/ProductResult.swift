//
//  ProductResult.swift
//  ECommerce
//
//  Created by mert can çifter on 25.02.2024.
//

import Foundation


struct ProductResult: Codable {
    let data: [Product]
}

struct Product: Codable {
    
    let id: Int
    let title: String
    let image: String
    let price: Double
    var isBasket: Bool = false
    var count: Int = 1
    
    private enum CodingKeys: String, CodingKey {
        case id, title, price, image
    }
    
}
