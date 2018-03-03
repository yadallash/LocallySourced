//
//  ShoppingListView.swift
//  LocallySourced
//
//  Created by Clint Mejia on 3/3/18.
//  Copyright © 2018 TeamLocallySourced. All rights reserved.
//

import UIKit
import SnapKit

class DetailShoppingListView: UIView {
    
    let cellID = "ItemCell"
    
    // MARK: - Lazy variables
    lazy var shoppingListTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ItemCell.self, forCellReuseIdentifier: cellID)
        return tableView
    }()
    
    // MARK: - Initializers
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
    
    // MARK: - Functions
    private func setupViews() {
        setupTableView()
    }
    
    
    func setupTableView() {
        addSubview(shoppingListTableView)
        shoppingListTableView.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            
        }
    }
}
