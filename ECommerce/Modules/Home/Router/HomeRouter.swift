//
//  HomeRouter.swift
//  ECommerce
//
//  Created by mert can çifter on 21.02.2024.
//

import UIKit


struct HomeRouter {
    
    var viewController: UIViewController
    
    typealias Submodules = (
        product: UIViewController,
        basket: UIViewController
    )
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension HomeRouter {
    
    static func tabs(usingSubmodules submodules: Submodules) -> Tabs {
        
        let productTabBarItem = UITabBarItem(title: "Product", image: UIImage(systemName: "house"), tag: 1)
        let basketTabBarItem = UITabBarItem(title: "Basket", image: UIImage(systemName: "cart"), tag: 2)
        
        submodules.product.tabBarItem = productTabBarItem
        submodules.basket.tabBarItem = basketTabBarItem
        
        return (
            product: submodules.product,
            basket: submodules.basket
        )
    }
}


