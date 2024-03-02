//
//  CustomStepper.swift
//  ECommerce
//
//  Created by mert can çifter on 28.02.2024.
//

import UIKit
import SnapKit

class CustomStepperView: UIView {

    private let valueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()

    private lazy var minusButton: UIButton = {
        let button = UIButton()
        button.setTitle(" - ", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        button.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)

        return button
    }()

    private lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setTitle(" + ", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)

        return button
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.tintColor = .gray
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)

        return button
    }()

    var value: Int = 0 {
        didSet {
            valueLabel.text = "\(value)"
        }
    }

    var onValueChanged: ((Int) -> Void)?
    var onDelete: ((Bool) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        addSubview(minusButton)
        addSubview(valueLabel)
        addSubview(plusButton)
        addSubview(deleteButton)

        minusButton.snp.makeConstraints { make in
            make.left.equalTo(snp.left)
            make.height.width.equalTo(30)
            make.bottom.equalTo(snp.bottom)
        }
        
        valueLabel.snp.makeConstraints { make in
            make.left.equalTo(minusButton.snp.right)
            make.height.width.equalTo(30)
            make.bottom.equalTo(snp.bottom)
        }
        
        plusButton.snp.makeConstraints { make in
            make.left.equalTo(valueLabel.snp.right)
            make.height.width.equalTo(30)
            make.bottom.equalTo(snp.bottom)

        }
        
        deleteButton.snp.makeConstraints { make in
            make.left.equalTo(plusButton.snp.right).offset(10)
            make.height.width.equalTo(30)
            make.bottom.equalTo(snp.bottom)

        }
    }


    @objc private func minusButtonTapped() {
        if value > 1 {
            value -= 1
            self.onValueChanged?(value)
        }
    }

    @objc private func plusButtonTapped() {
        value += 1
        self.onValueChanged?(value)
    }
    
    @objc private func deleteButtonTapped() {
        onDelete?(true)
    }
}


extension CustomStepperView {
    func configure(count: Int) {
        self.value = count
    }
}
