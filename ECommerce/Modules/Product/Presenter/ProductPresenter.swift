//
//  ProductPresenter.swift
//  ECommerce
//
//  Created by mert can çifter on 22.02.2024.
//

import Foundation


protocol ProductPresentation {
    
    func viewDidLoad() -> Void
    
    func onAddToBasket(product: Product) -> Void
}

class ProductPresenter {
    
    weak var view: ProductView?
    var interactor: ProductUseCase
    var router: ProductRouting
    
    init(view: ProductView, interactor: ProductUseCase, router: ProductRouting) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension ProductPresenter: ProductPresentation {
    
    func viewDidLoad() -> Void {
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.interactor.getProducts { result in
                DispatchQueue.main.async {
                    self?.view?.updateProducts(products: result.data)
                }
            }
        }
    }
    
    
    func onAddToBasket(product: Product) -> Void {
        
        DispatchQueue.global(qos: .background).async {
            self.interactor.addBasket(product: product)
        }
    }
    
    
}
