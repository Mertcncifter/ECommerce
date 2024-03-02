//
//  HomeViewBuilder.swift
//  ECommerce
//
//  Created by mert can çifter on 22.02.2024.
//

import UIKit

class HomeViewBuilder {
    
    static func build(usingSubmodules submodules: HomeRouter.Submodules) -> UITabBarController {
        
        let tabs = HomeRouter.tabs(usingSubmodules: submodules)
        let tabBarController = HomeViewController(tabs: tabs)
        let interactor = HomeInteractor(database: RealmDatabase.shared)
        let presenter = HomePresenter(view: tabBarController, interactor: interactor)
        tabBarController.presenter = presenter
        return tabBarController
        
    }
}
