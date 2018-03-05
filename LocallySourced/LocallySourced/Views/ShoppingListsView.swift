//
//  ShoppingListsView.swift
//  LocallySourced
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 TeamLocallySourced. All rights reserved.
//

import UIKit

class ShoppingListsView: UIView {
    
    lazy var listTableView: UITableView = {
        let tv = UITableView()
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "ListCell")
        tv.register(ShoppingListsTableViewCell.self, forCellReuseIdentifier: "customShoppingListsCell")
//        tv.backgroundColor = .clear
        tv.separatorColor = .clear
        
        return tv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews(){
        addSubview(listTableView)
        
        listTableView.snp.makeConstraints { (view) in
            view.edges.equalTo(self)
        }
    }

}
