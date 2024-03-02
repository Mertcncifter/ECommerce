//
//  BasketViewController.swift
//  ECommerce
//
//  Created by mert can çifter on 22.02.2024.
//

import UIKit
import SnapKit

protocol BasketView: class {
    func updateBaskets(baskets: [BasketItemViewModel]) -> ()
}


class BasketViewController: UIViewController {

    // MARK: -- Properties
    
    var dataSource: [BasketItemViewModel] = []

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero,style: .grouped)
        tableView.backgroundColor = .systemBackground
        tableView.register(BasketTableViewCell.self, forCellReuseIdentifier: BasketTableViewCell.identifier)
        return tableView
    }()
    
    private let fixedView: BasketFixedView = {
        let fixedView = BasketFixedView()
        return fixedView
    }()
    
    var presenter: BasketPresentation!
    
    
    // MARK: -- Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter.viewDidLoad()

        view.backgroundColor = .white
        
        self.navigationItem.title = "Basket"
        
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(fixedView)
        
        fixedView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(70)
            make.left.right.equalToSuperview()
        }
       
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
}

extension BasketViewController: BasketView {
    func updateBaskets(baskets: [BasketItemViewModel]) {
        self.dataSource = baskets
        let totalPrice = baskets.map { $0.price * Double($0.count) }.reduce(0, +)
        self.fixedView.configurePrice(price: "\(totalPrice)")
        self.tableView.reloadData()
    }
    
    
}


extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BasketTableViewCell.identifier, for: indexPath) as? BasketTableViewCell else {
            return UITableViewCell()
        }
        
        let data = self.dataSource[indexPath.row]
        cell.configure(model: data)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}

extension BasketViewController: BasketTableViewCellDelegate {
    func changeCount(productId: Int, count: Int) {
        self.presenter.changeCount(productId: productId, count: count)
    }
    
    func delete(productId: Int) {
        self.presenter.delete(productId: productId)

    }
    
    
}


//#Preview {
//  BasketViewController()
//}
