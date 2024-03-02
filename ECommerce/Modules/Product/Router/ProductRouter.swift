//
//  ProductRouter.swift
//  ECommerce
//
//  Created by mert can çifter on 22.02.2024.
//

import UIKit

protocol ProductRouting {
    
}


class ProductRouter {
    
    var viewController: UIViewController
    
    init(view: UIViewController) {
        self.viewController = view
    }
}


extension ProductRouter: ProductRouting {
    
}
