//
//  MarketCustomTableViewCell.swift
//  LocallySourced
//
//  Created by C4Q on 3/4/18.
//  Copyright © 2018 TeamLocallySourced. All rights reserved.
//

import UIKit

class MarketCustomTableViewCell: UITableViewCell {
    lazy var boroughLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter label Name Here"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textColor = UIColor.white
        label.textAlignment = .left
        return label
    }()
    lazy var marketLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter label Name Here"
        label.font = UIFont.boldSystemFont(ofSize: 23)
        label.numberOfLines = 0
        label.textColor = UIColor.white
        label.textAlignment = .left
        return label
    }()
    lazy var layerMask: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.opacity = 0.25
        return view
    }()
    lazy var containerView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    //Add your subViews here
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        //configure the cell reusable identifier here
        super.init(style: style, reuseIdentifier: "customMarketTableViewCell")
        setupViews()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        //configure your layout here
        self.selectionStyle = UITableViewCellSelectionStyle.none
        containerView.layer.cornerRadius = 15
    }
    private func setupViews() {
        //Add your views setup here
        setupContainerView()
        setupLayerMask()
        setupMarketLabel()
        setupBouroghLabel()
    }
    private func setupContainerView() {
        addSubview(containerView)
        containerView.snp.makeConstraints { (constraint) in
            constraint.centerX.equalTo(snp.centerX)
            constraint.centerY.equalTo(snp.centerY)
            constraint.width.equalTo(snp.width).multipliedBy(0.95)
            constraint.height.equalTo(snp.height).multipliedBy(0.95)
        }
    }
    func setupLayerMask() {
        containerView.addSubview(layerMask)
        layerMask.snp.makeConstraints { (constraint) in
            constraint.edges.equalTo(containerView.snp.edges)
        }
    }
    func setupMarketLabel() {
        containerView.addSubview(marketLabel)
        marketLabel.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(containerView.snp.top).offset(10)
            constraint.left.equalTo(containerView.snp.left).offset(10)
            constraint.right.equalTo(containerView.snp.right).offset(-10)
        }
    }
    func setupBouroghLabel(){
        containerView.addSubview(boroughLabel)
        boroughLabel.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(marketLabel.snp.bottom).offset(10)
            constraint.left.equalTo(containerView.snp.left).offset(10)
            constraint.right.equalTo(containerView.snp.right).offset(-10)
        }
    }
}
