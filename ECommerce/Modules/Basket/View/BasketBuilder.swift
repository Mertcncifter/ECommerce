//
//  BasketBuilder.swift
//  ECommerce
//
//  Created by mert can çifter on 23.02.2024.
//

import UIKit


class BasketBuilder {
    
    static func build() -> UIViewController {
        
        let view = BasketViewController()
        
        let interactor = BasketInteractor(service: ProductService.shared, database: RealmDatabase.shared)
        let router = BasketRouter(view: view)
        
        let presenter = BasketPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        
        return view
        
    }
}
