//
//  RealmProductItem.swift
//  ECommerce
//
//  Created by mert can çifter on 26.02.2024.
//

import RealmSwift


class RealmBasketItem: Object {
    @Persisted(primaryKey: true) var productId: Int
    @Persisted var title: String
    @Persisted var image: String
    @Persisted var price: Double
    @Persisted var count: Int
}


extension RealmBasketItem {
    
    convenience init(product: Product) {
        self.init()
        self.productId = product.id
        self.title = product.title
        self.image = product.image
        self.price = product.price
        self.count = product.count
    }
}

extension Product {
    
    init(realmProductItem: RealmBasketItem) {
        self.id = realmProductItem.productId
        self.title = realmProductItem.title
        self.image = realmProductItem.image
        self.price = realmProductItem.price
        self.count = realmProductItem.count
        
    }
}

