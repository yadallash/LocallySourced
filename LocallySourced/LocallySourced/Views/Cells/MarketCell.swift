//
//  marketCell.swift
//  LocallySourced
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 TeamLocallySourced. All rights reserved.
//

import UIKit

class MarketCell: UITableViewCell {
    
    lazy var marketName: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var marketEBTStatus: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    lazy var marketCity: UILabel = {
        let label = UILabel()
        return label
    }()
    lazy var containerView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .cyan
        return imageView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layer.cornerRadius = 15
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }


    func setUpView() {
        addSubview(marketName)
        addSubview(marketEBTStatus)
        addSubview(marketCity)
        
        marketName.snp.makeConstraints { (make) in
            make.top.leading.equalTo(self).offset(5)
        }
        marketCity.snp.makeConstraints { (make) in
            make.leading.equalTo(self).offset(5)
            make.bottom.equalTo(self).offset(-5)
        }
        
    }
    func setupContainerView() {
        addSubview(containerView)
        containerView.snp.makeConstraints { (constraint) in
            constraint.centerX.equalTo(snp.centerX)
            constraint.centerY.equalTo(snp.centerY)
            constraint.width.equalTo(snp.width).multipliedBy(0.95)
            constraint.height.equalTo(snp.height).multipliedBy(0.95)
        }
    }

}
