//
//  HomePresenter.swift
//  ECommerce
//
//  Created by mert can çifter on 28.02.2024.
//

import Foundation


protocol HomePresentation {
    func viewDidLoad() -> Void
}

class HomePresenter {
    weak var view: HomeView?
    var interactor: HomeUseCase
    
    init(view: HomeView? = nil, interactor: HomeUseCase) {
        self.view = view
        self.interactor = interactor
    }
}

extension HomePresenter: HomePresentation {
    func viewDidLoad() {
        self.interactor.getBasketCount { self.view?.updateBasketCount(count: $0)}
    }
}
