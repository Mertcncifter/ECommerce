//
//  RealmDatabase.swift
//  ECommerce
//
//  Created by mert can çifter on 23.02.2024.
//

import Foundation
import RealmSwift


class RealmDatabase {
    static let shared: RealmDatabase = RealmDatabase()
    var notificationToken: NotificationToken?
    var notificationTokenBasket: NotificationToken?
    var manager: RealmManager = RealmManager()
    
    private init() {}
    
    deinit {
        notificationToken?.invalidate()
        notificationTokenBasket?.invalidate()
    }
}

extension RealmDatabase: ProductDB {
    
    func addBasket(product: Product) {
        let predicate = NSPredicate(format: "productId == %d", product.id)

        if let existSameProduct = manager.read(RealmBasketItem.self, predicate: predicate) {
            let count = existSameProduct.count + 1
            manager.update(existSameProduct, with: ["count": count])
        }
        else {
            manager.create(RealmBasketItem(product: product))
        }
    }
    
    func getBasketCount(closure: @escaping (Int) -> (Void)) {
        
        let realm = manager.getRealm()
        
        let results = realm.objects(RealmBasketItem.self)
        
        notificationToken = results.observe({ _ in
            closure(results.count)
        })
    }
    
    func getBasketItems(closure: @escaping ([RealmBasketItem]?) -> (Void)) {
        let realm = manager.getRealm()

        let results = realm.objects(RealmBasketItem.self)

        notificationTokenBasket = results.observe({ _ in
            closure(results.toArray(ofType: RealmBasketItem.self))
        })
    }
    
    func changeBasketCount(productId: Int, count: Int) {
        let predicate = NSPredicate(format: "productId == %d", productId)

        if let existSameProduct = manager.read(RealmBasketItem.self, predicate: predicate) {
            manager.update(existSameProduct, with: ["count": count])
        }
    }
    
    func deleteBasket(productId: Int) {
        let predicate = NSPredicate(format: "productId == %d", productId)

        if let existSameProduct = manager.read(RealmBasketItem.self, predicate: predicate) {
            manager.delete(existSameProduct)
        }
    }
}



