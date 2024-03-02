//
//  ProductBuilder.swift
//  ECommerce
//
//  Created by mert can çifter on 22.02.2024.
//

import UIKit

class ProductBuilder {
    
    static func build() -> UIViewController {
        
        let view = ProductViewController()
        
        let interactor = ProductInteractor(service: ProductService.shared, database: RealmDatabase.shared)
        let router = ProductRouter(view: view)
        
        let presenter = ProductPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        return view
    }
}
