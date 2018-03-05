//
//  TestingCell.swift
//  LocallySourced
//
//  Created by C4Q on 3/4/18.
//  Copyright © 2018 TeamLocallySourced. All rights reserved.
//

import UIKit

class CityCell: UICollectionViewCell {
    
    lazy var testingImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    lazy var testingOverView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 10
        view.layer.opacity = 0.30
        return view
    }()
    
    lazy var testingLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        self.layer.cornerRadius = 15
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit() {
        backgroundColor = .white
        setupViews()
    }
    private func setupViews() {
        addSubview(testingImageView)
        addSubview(testingOverView)
        addSubview(testingLabel)
        
        testingImageView.snp.makeConstraints { (image) in
            image.edges.equalTo(self)
        }
        testingOverView.snp.makeConstraints { (view) in
            view.edges.equalTo(self)
        }
        
        testingLabel.snp.makeConstraints { (make) in
            make.center.equalTo(testingImageView)
            make.width.equalTo(self).multipliedBy(0.9)
            
        }
    }
}
