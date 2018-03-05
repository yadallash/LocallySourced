//
//  ItemCell.swift
//  LocallySourced
//
//  Created by Clint Mejia on 3/3/18.
//  Copyright © 2018 TeamLocallySourced. All rights reserved.
//

import UIKit
import SnapKit

extension Double {
    var cleanValue: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

protocol ItemCellDelegate: class {
    func stepperButtonPressed(item: Item)
}

class ItemCell: UITableViewCell {
    
    // MARK: - Delegate
    weak var delegate: ItemCellDelegate?
    
    private var currentItem: Item!
    
    // MARK: - Outlets
    lazy var itemLabel: UILabel = {
        let label = UILabel()
        label.text = "Carrots"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    lazy var stepperValueLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    lazy var stepperButton: UIStepper = {
        let stepper = UIStepper()
        stepper.tintColor = UIColor.black
        stepper.minimumValue = 0
        stepper.maximumValue = 50
        stepper.value = 0
        stepper.stepValue = 1
        stepper.autorepeat = true
        stepper.isContinuous = true
        stepper.wraps = false
        stepper.addTarget(self, action: #selector(stepperButtonPressed), for: .valueChanged)
        return stepper
    }()
    
    lazy var checkMarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "unchecked")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Initializers
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Functions
    func addSubviews() {
        addSubview(itemLabel)
        addSubview(stepperButton)
        addSubview(stepperValueLabel)
        addSubview(checkMarkImageView)
    }
    
    func setUpView() {
        setupItemLabel()
        setupStepperButton()
        setupStepperValueLabel()
        setupCheckMarkImageView()
    }
    
    @objc func stepperButtonPressed() {
        stepperValueLabel.text = stepperButton.value.cleanValue
        currentItem.amount = stepperButton.value
        delegate?.stepperButtonPressed(item: currentItem)
    }
    
    // refer to cell height for image size, not width (eg self)
    func setupCheckMarkImageView() {
        checkMarkImageView.snp.makeConstraints { (make) in
            make.width.equalTo(self.bounds.height/2)
            make.height.equalTo(self.bounds.height/2)
            make.centerY.equalTo(self)
            make.leading.equalTo(self).offset(8)
        }
    }
    
    func setupItemLabel() {
        itemLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(snp.centerY)
            make.leading.equalTo(checkMarkImageView.snp.trailing).offset(14)
            make.width.equalTo(snp.width).multipliedBy(0.5)
        }
    }
    
    func setupStepperValueLabel() {
        stepperValueLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(snp.centerY)
            make.trailing.equalTo(stepperButton.snp.leading).offset(-14)
            make.width.equalTo(self.bounds.width / 9.5)
            make.height.equalTo(itemLabel.snp.height)
        }
    }
    
    func setupStepperButton() {
        stepperButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.trailing.equalTo(self).offset(-5)
        }
    }
    
    
    func configureCell(with groceryItem: Item) {
        self.currentItem = groceryItem
        self.itemLabel.text = groceryItem.name
        self.stepperButton.value = groceryItem.amount
        self.stepperValueLabel.text = String(groceryItem.amount.cleanValue)
    }
    
}

