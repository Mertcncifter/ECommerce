//
//  BasketFixedView.swift
//  ECommerce
//
//  Created by mert can çifter on 2.03.2024.
//

import UIKit
import SnapKit

class BasketFixedView: UIView {
    
    private let priceTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: "#FF6D1B")
        label.text = "Selected Products"
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    private let button : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Completed Shopping", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hex: "#FF6D1B")
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12,weight: .regular)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
   
        backgroundColor = UIColor(hex: "#FFFFFF")
        let stackView = UIStackView(arrangedSubviews: [priceTitleLabel,priceLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = UIStackView.Alignment.center

        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.left.equalTo(snp.left).offset(10)
            make.bottom.equalTo(snp.bottom).offset(-10)
        }
        
        addSubview(button)
        
        button.snp.makeConstraints { make in
            make.right.equalTo(snp.right).offset(-5)
            make.height.equalTo(50)
            make.width.equalTo(170)
            make.bottom.equalTo(snp.bottom).offset(-10)
        }
    }
}

extension BasketFixedView {
    func configurePrice(price: String) {
        priceLabel.text = "\(price) TL"
    }
}
