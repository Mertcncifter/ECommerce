//
//  Viewable.swift
//  ECommerce
//
//  Created by mert can çifter on 21.02.2024.
//

import Foundation
import UIKit

protocol Viewable {
    func present(_ viewController: UIViewController)
    func dismiss()
}

extension Viewable where Self: UIViewController {
    func present(_ viewController: UIViewController) {
        self.present(viewController, animated: true)
    }

    func dismiss() {
        self.dismiss()
    }
}
