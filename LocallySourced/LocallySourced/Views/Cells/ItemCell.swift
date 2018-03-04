//
//  ItemCell.swift
//  LocallySourced
//
//  Created by Clint Mejia on 3/3/18.
//  Copyright © 2018 TeamLocallySourced. All rights reserved.
//

import UIKit
import SnapKit

extension Float {
    var cleanValue: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

protocol ItemCellDelegate: class {
    func stepperButtonPressed()
    func checkedButtonPressed()
}

class ItemCell: UITableViewCell {
    
    // MARK: - Delegate
    weak var delegate: ItemCellDelegate?
    
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
        label.textAlignment = .left
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
    
    lazy var checkMarkButton: UIButton = {
        let button = UIButton(type: UIButtonType.custom) as UIButton
        button.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(checkedButtonPressed), for: .touchUpInside)
        return button
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
        addSubview(checkMarkButton)
    }
    
    func setUpView() {
        setupItemLabel()
        setupStepperButton()
        setupStepperValueLabel()
        setupCheckMarkButton()
    }
    
    func isItemComplete(_ currentState: Item) {
        guard currentState.completed == false else {
            return self.checkMarkButton.setImage(#imageLiteral(resourceName: "checked"), for: .selected)
        }
        return self.checkMarkButton.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
    }
    
    @objc func stepperButtonPressed() {
        stepperValueLabel.text = stepperButton.value.description
        delegate?.stepperButtonPressed()
    }
    
    @objc private func checkedButtonPressed() {
        delegate?.checkedButtonPressed()
    }
    
    // refer to cell height for image size, not width (eg self)
    func setupCheckMarkButton() {
        checkMarkButton.snp.makeConstraints { (make) in
            make.width.equalTo(self.bounds.height/2)
            make.height.equalTo(self.bounds.height/2)
            make.centerY.equalTo(self)
            make.leading.equalTo(self).offset(8)
        }
    }
    
    func setupItemLabel() {
        itemLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(snp.centerY)
            make.leading.equalTo(checkMarkButton.snp.trailing).offset(10)
            make.width.equalTo(snp.width).multipliedBy(0.5)
        }
    }
    
    func setupStepperValueLabel() {
        stepperValueLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(snp.centerY)
            make.trailing.equalTo(stepperButton.snp.leading).offset(-10)
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
        self.itemLabel.text = groceryItem.name
        self.stepperButton.value = groceryItem.amount
        self.stepperValueLabel.text = String(groceryItem.amount)
        self.isItemComplete(groceryItem)
    }
    
}

