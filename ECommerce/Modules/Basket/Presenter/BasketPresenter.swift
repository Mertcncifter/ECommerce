//
//  BasketPresenter.swift
//  ECommerce
//
//  Created by mert can çifter on 23.02.2024.
//

import Foundation


protocol BasketPresentation {
    func viewDidLoad() -> Void
    func changeCount(productId: Int, count: Int) -> Void
    func delete(productId: Int) -> Void
}


class BasketPresenter {
    
    weak var view: BasketView?
    var interactor: BasketUseCase
    var router: BasketRouter
    
    init(view: BasketView, interactor: BasketUseCase, router: BasketRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}


extension BasketPresenter: BasketPresentation {
    
    func viewDidLoad() {
        
        self.interactor.getBaskets { baskets in
            let basketList = baskets?.compactMap({BasketItemViewModel(using: $0)})
            self.view?.updateBaskets(baskets: basketList ?? [])
        }
    }
    
    func changeCount(productId: Int, count: Int) {
        self.interactor.changeCount(productId: productId, count: count)
    }
    
    func delete(productId: Int) {
        self.interactor.deleteBasket(productId: productId)
    }
}


struct BasketItemViewModel {
    
    let productId: Int
    let title: String
    let image: String
    let price: Double
    var count: Int
    
    init(using basket: RealmBasketItem) {
        self.productId = basket.productId
        self.title = basket.title
        self.image = basket.image
        self.price = basket.price
        self.count = basket.count
    }
}
