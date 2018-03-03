//
//  ItemCell.swift
//  LocallySourced
//
//  Created by Clint Mejia on 3/3/18.
//  Copyright © 2018 TeamLocallySourced. All rights reserved.
//

import UIKit
import SnapKit

class ItemCell: UITableViewCell {
    
    
    // MARK: - Outlets
    lazy var itemLabel: UILabel = {
        let label = UILabel()
        label.text = "Carrots"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    lazy var stepperButton: UIStepper = {
        let stepper = UIStepper()
        stepper.minimumValue = 0
        stepper.maximumValue = 50
        stepper.value = 0
        stepper.stepValue = 1
        stepper.autorepeat = true
        stepper.isContinuous = true
        stepper.wraps = false
        return stepper
    }()
    
    // MARK: - Initializers
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Functions\
    func addSubviews() {
        addSubview(itemLabel)
        addSubview(stepperButton)
    }
    
    func setUpView() {
        setupItemLabel()
        setupStepperButton()
    }
    
    func setupItemLabel() {
        itemLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(8)
            //            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.2)
        }
    }
    
    func setupStepperButton() {
        stepperButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.leading).offset(-8)
            //            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.2)
        }
    }
}

