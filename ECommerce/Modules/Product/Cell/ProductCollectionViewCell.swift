//
//  ProductCollectionViewCell.swift
//  ECommerce
//
//  Created by mert can çifter on 24.02.2024.
//

import UIKit
import SnapKit
import SDWebImage

protocol ProductCollectionViewCellDelegate: AnyObject {
    func addBasket(productId: Int)
}

class ProductCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: ProductCollectionViewCell.self)

    weak var delegate: ProductCollectionViewCellDelegate?
    
    var model: Product? {
        didSet {
            
            guard let model = model else {
                return
            }
            
            self.titleLabel.text = model.title
            self.priceLabel.text = "\(model.price) TL"
            self.imageView.image = UIImage(named: model.image)
            
            if model.isBasket {
                self.button.backgroundColor = UIColor(hex: "#7CD070")
                self.button.setTitle("Added To Basket", for: .normal)
            }
        }
    }
    
    // MARK: - Properties
        
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 3
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    private let button : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add Basket", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hex: "#FF6D1B")
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12,weight: .regular)
        button.addTarget(self, action: #selector(handleBasket), for: .touchUpInside)
        return button
    }()
    
    @objc func handleBasket() {
        guard let model = model else { return }
        
        if model.isBasket == false {
            delegate?.addBasket(productId: model.id)
            self.button.backgroundColor = UIColor(hex: "#7CD070")
            self.button.setTitle("Added To Basket", for: .normal)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        button.backgroundColor = UIColor(hex: "#FF6D1B")
        button.setTitle("Add Basket", for: .normal)
        self.titleLabel.text = ""
        self.priceLabel.text = ""
        self.imageView.image = nil
        
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
}

extension ProductCollectionViewCell {
    func configureSubviews() {
        
        contentView.layer.borderWidth = 1.0
        contentView.layer.cornerRadius = 10
        contentView.layer.borderColor = UIColor(hex: "#7D7D7D").cgColor

        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(button)
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(5)
            make.right.equalTo(contentView.snp.right).offset(-10)
            make.left.equalTo(contentView.snp.left).offset(10)
            make.height.equalTo(250)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(5)
            make.right.equalTo(contentView.snp.right).offset(-10)
            make.left.equalTo(contentView.snp.left).offset(10)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.right.equalTo(contentView.snp.right).offset(-10)
            make.left.equalTo(contentView.snp.left).offset(10)
        }
        
        button.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(5)
            make.right.equalTo(contentView.snp.right).offset(-10)
            make.left.equalTo(contentView.snp.left).offset(10)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
            make.height.equalTo(27)
        }
    }
}

extension ProductCollectionViewCell {
    func configure(model: Product) {
        self.model = model
    }
}
