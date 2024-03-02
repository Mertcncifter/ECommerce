//
//  ProductInteractor.swift
//  ECommerce
//
//  Created by mert can çifter on 22.02.2024.
//

import Foundation



protocol ProductUseCase {
    func getProducts(completion: (ProductResult) -> (Void)) -> (Void)
    func addBasket(product: Product)
}

class ProductInteractor {
    var service: ProductAPI
    var database: ProductDB
    
    init(service: ProductAPI, database: ProductDB) {
        self.service = service
        self.database = database
    }
}

extension ProductInteractor: ProductUseCase {
    
    func getProducts(completion: (ProductResult) -> (Void)) {
        self.service.fetchProducts { result in
            completion(result)
        }
    }
    
    func addBasket(product: Product) {
        self.database.addBasket(product: product)
    }
}
