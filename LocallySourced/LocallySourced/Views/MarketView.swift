//
//  TestMarketView.swift
//  LocallySourced
//
//  Created by C4Q on 3/4/18.
//  Copyright © 2018 TeamLocallySourced. All rights reserved.
//

import UIKit

class MarketView: UIView {

    lazy var marketCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        cView.backgroundColor = .white
        cView.register(CityCell.self, forCellWithReuseIdentifier: "TestCell")
        return cView
    }()
    
    lazy var marketTableView: UITableView = {
        let tv = UITableView()
        tv.register(MarketCell.self, forCellReuseIdentifier: "MarketCell")
        tv.register(MarketCustomTableViewCell.self, forCellReuseIdentifier: "customMarketTableViewCell")
        tv.separatorColor = .clear
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        let viewObjects = [marketTableView, marketCollectionView] as! [UIView]
        viewObjects.forEach{addSubview($0)}
        
        marketCollectionView.snp.makeConstraints { (view) in
            view.top.leading.trailing.equalTo(self)
            view.height.equalTo(self).multipliedBy(0.25)
        }
        
        marketTableView.snp.makeConstraints { (view) in
            view.centerX.equalTo(self)
            //            view.height.equalTo(self.snp.height).multipliedBy(0.5)
            view.top.equalTo(marketCollectionView.snp.bottom).offset(10)
            view.leading.trailing.bottom.equalTo(self)
        }
    }
}
