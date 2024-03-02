//
//  BasketInteractor.swift
//  ECommerce
//
//  Created by mert can çifter on 23.02.2024.
//

import Foundation


protocol BasketUseCase {
    func getBaskets(completion: @escaping ([RealmBasketItem]?) -> (Void)) -> (Void)
    func changeCount(productId: Int, count: Int)
    func deleteBasket(productId: Int)
}

class BasketInteractor {
    var service: ProductAPI
    var database: ProductDB
    
    init(service: ProductAPI, database: ProductDB) {
        self.service = service
        self.database = database
    }
}


extension BasketInteractor: BasketUseCase {
    func getBaskets(completion: @escaping ([RealmBasketItem]?) -> (Void)) {
        self.database.getBasketItems { items in
            completion(items)
        }
    }
    
    func changeCount(productId: Int, count: Int) {
        self.database.changeBasketCount(productId: productId, count: count)
    }
    
    func deleteBasket(productId: Int) {
        self.database.deleteBasket(productId: productId)
    }
}
