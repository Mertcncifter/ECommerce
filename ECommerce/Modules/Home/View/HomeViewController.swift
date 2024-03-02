//
//  HomeViewController.swift
//  ECommerce
//
//  Created by mert can çifter on 21.02.2024.
//

import UIKit

typealias Tabs = (
    product: UIViewController,
    basket: UIViewController
)

protocol HomeView: class {
    func updateBasketCount(count: Int) -> Void
}

class HomeViewController: UITabBarController {

    // MARK: -- Properties
    
    var presenter: HomePresentation?
    
    
    // MARK: -- Lifecycle
    
    init(tabs: Tabs) {
        super.init(nibName: nil, bundle: nil)
        setViewControllers([tabs.product,tabs.basket], animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.presenter?.viewDidLoad()

    }
    
}

// MARK: -- UI Draw

extension HomeViewController {
    
    private func configureUI() {
        configureTabBarAppereance()
    }
    
    private func configureTabBarAppereance() {
        let appearance = UITabBarAppearance()
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .systemGroupedBackground
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
            tabBar.tintColor = .label
        }
        else{
            tabBar.standardAppearance = appearance
            tabBar.tintColor = .label
        }
    }
}


// MARK: -- Helpers

extension HomeViewController: HomeView {
    func updateBasketCount(count: Int) {
        viewControllers?[1].tabBarItem.badgeValue = "\(count)"
    }
    
    
    
    
}

