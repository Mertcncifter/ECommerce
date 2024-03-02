//
//  ProductInteractor.swift
//  ECommerce
//
//  Created by mert can çifter on 28.02.2024.
//

import Foundation


protocol HomeUseCase {
    func getBasketCount(closure: @escaping (Int) -> (Void)) -> (Void)
}

class HomeInteractor {
   
    var database: ProductDB
    init(database: ProductDB) {
        self.database = database
    }
    
}

extension HomeInteractor: HomeUseCase {
    func getBasketCount(closure: @escaping (Int) -> (Void)) {
        self.database.getBasketCount(closure: closure)
    }
    
    
}
