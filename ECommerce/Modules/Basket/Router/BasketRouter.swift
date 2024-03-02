//
//  BasketRouter.swift
//  ECommerce
//
//  Created by mert can çifter on 23.02.2024.
//

import UIKit

protocol BasketRouting {
    
}


class BasketRouter {
    
    let view: UIViewController
    
    init(view: UIViewController) {
        self.view = view
    }
}

extension BasketRouter: BasketRouting {
    
}
