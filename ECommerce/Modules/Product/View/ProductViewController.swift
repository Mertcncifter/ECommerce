//
//  ProductViewController.swift
//  ECommerce
//
//  Created by mert can çifter on 21.02.2024.
//

import UIKit

protocol ProductView: class {
    func updateProducts(products: [Product]) -> ()
}

class ProductViewController: UIViewController {

    var presenter: ProductPresentation!
    
    var dataSource: [Product] = []
    
    private lazy var collectionView = UICollectionView(frame: .zero,collectionViewLayout:
         UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
        
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(350)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(350)), subitems: [item])
        group.interItemSpacing = .fixed(15)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 15
        return section
            
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter.viewDidLoad()

        view.backgroundColor = .white
        self.navigationItem.title = "Product"
        
        view.addSubview(collectionView)
        
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)

        
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
        
}


extension ProductViewController: ProductView {
    func updateProducts(products: [Product]) {
        self.dataSource = products
        self.collectionView.reloadData()

    }
    
    
    
}

extension ProductViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as? ProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let data = dataSource[indexPath.row]
        cell.configure(model: data)
        cell.delegate = self
        return cell
    }
    
}

extension ProductViewController: ProductCollectionViewCellDelegate {
    
    func addBasket(productId: Int) {
        
        guard let index = self.dataSource.firstIndex(where: {$0.id == productId }) else { return }
        
        if dataSource[index].isBasket == false {
            self.dataSource[index].isBasket = true
            self.presenter.onAddToBasket(product: dataSource[index])
        }
    }
}
