//
//  BasketTableViewCell.swift
//  ECommerce
//
//  Created by mert can çifter on 28.02.2024.
//

import UIKit
import SnapKit

protocol BasketTableViewCellDelegate: AnyObject {
    func changeCount(productId: Int, count: Int)
    func delete(productId: Int)
}


class BasketTableViewCell: UITableViewCell {

    static let identifier = String(describing: BasketTableViewCell.self)

    weak var delegate: BasketTableViewCellDelegate?

    var model: BasketItemViewModel? {
        didSet {
            
            guard let model = model else {
                return
            }
            
            self.titleLabel.text = model.title
            self.priceLabel.text = "\(model.price) TL"
            self.productImageView.image = UIImage(named: model.image)
            
            stepperView.onValueChanged = { count in

                self.delegate?.changeCount(productId: model.productId, count: count)
            }
            
            stepperView.onDelete = { state in

                self.delegate?.delete(productId: model.productId)
            }
        }
    }
    
    private lazy var productImageView: UIImageView = {
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
    
    private let stepperView: CustomStepperView = {
        var stepperView = CustomStepperView()
        return stepperView
    }()
    
      
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = ""
        self.priceLabel.text = ""
        self.productImageView.image = nil
        self.stepperView.configure(count: 1)
    }

}

extension BasketTableViewCell {
    
    func configureSubviews() {
        
        contentView.addSubview(productImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(stepperView)

        productImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(5)
            make.left.equalTo(contentView.snp.left).offset(5)
            make.height.width.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(5)
            make.left.equalTo(productImageView.snp.right).offset(5)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.snp.bottom).offset(-5)
            make.right.equalTo(contentView.snp.right).offset(-5)
        }
        
        stepperView.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.snp.bottom).offset(-5)
            make.left.equalTo(contentView.snp.left).offset(10)
            make.width.equalTo(150)
            make.height.equalTo(30)
        }
    }
}


extension BasketTableViewCell {
    func configure(model: BasketItemViewModel) {
        self.model = model
        
        stepperView.configure(count: model.count)
        
        
    }
}
