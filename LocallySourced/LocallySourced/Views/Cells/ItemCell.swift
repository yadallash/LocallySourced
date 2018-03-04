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

protocol FeedCellDelegate: class {
    func stepperButtonPressed()
}

class ItemCell: UITableViewCell {
    
    // MARK: - Delegate
    weak var delegate: FeedCellDelegate?
    
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
    
    // MARK: - Initializers
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Functions\
    func addSubviews() {
        addSubview(itemLabel)
        addSubview(stepperButton)
        addSubview(stepperValueLabel)
    }
    
    func setUpView() {
        setupItemLabel()
        setupStepperButton()
        setupStepperValueLabel()
    }

    @objc func stepperButtonPressed() {
        stepperValueLabel.text = stepperButton.value.description
    }
    
    func setupItemLabel() {
        itemLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(snp.centerY)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(20)
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
    
    func configureCell(with groceryItem: GroceryItem) {
        self.itemLabel.text = groceryItem.name
        self.stepperButton.value = groceryItem.quantity
        self.stepperValueLabel.text = String(groceryItem.quantity)
    }

}

