//
//  HomeView.swift
//  LocallySourced
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 TeamLocallySourced. All rights reserved.
//

import UIKit
import SnapKit
class MarketsView: UIView {
    
    
    lazy var filterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Select a City", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        return button
    }()
    
    lazy var buttonTableView: UITableView = {
        let tv = UITableView()
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "FilterCell")
        tv.isHidden = true
        return tv
    }()
    
    lazy var marketTableView: UITableView = {
        let tv = UITableView()
        tv.register(MarketCell.self, forCellReuseIdentifier: "MarketCell")
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
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
        let viewObjects = [marketTableView, filterButton, buttonTableView] as! [UIView]
        viewObjects.forEach{addSubview($0)}
        
        filterButton.snp.makeConstraints { (button) in
            button.top.equalTo(self).offset(10)
            button.trailing.equalTo(self).offset(-10)
            button.width.equalTo(self).multipliedBy(0.5)
        }
        
        buttonTableView.snp.makeConstraints { (view) in
            view.width.equalTo(filterButton)
            view.top.equalTo(filterButton.snp.bottom)
            view.trailing.equalTo(self)
            view.height.equalTo(self).multipliedBy(0.4)
        }
        
        marketTableView.snp.makeConstraints { (view) in
            view.centerX.equalTo(self)
//            view.height.equalTo(self.snp.height).multipliedBy(0.5)
            view.top.equalTo(filterButton.snp.bottom).offset(10)
            view.leading.trailing.bottom.equalTo(self)
            
        }
        
        
    }
    
}
