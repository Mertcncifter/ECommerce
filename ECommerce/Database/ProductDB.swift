//
//  ProductDB.swift
//  ECommerce
//
//  Created by mert can çifter on 26.02.2024.
//

import Foundation
import RealmSwift


protocol ProductDB {
    func addBasket(product: Product)
    func getBasketCount(closure: @escaping (Int) -> (Void)) -> (Void)
    func getBasketItems(closure: @escaping ([RealmBasketItem]?) -> Void) -> (Void)
    func changeBasketCount(productId: Int, count: Int)
    func deleteBasket(productId: Int)
}
