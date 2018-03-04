//
//  FavoritesView.swift
//  LocallySourced
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 TeamLocallySourced. All rights reserved.
//

import UIKit

class FavoritesView: UIView {
    
    lazy var favoriteTableView: UITableView = {
        let tView = UITableView()
        tView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: "customCell")
        return tView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews(){
        setupTableView()
    }
    func setupTableView() {
        addSubview(favoriteTableView)
        favoriteTableView.snp.makeConstraints { (constraint) in
            constraint.edges.equalTo(snp.edges)
        }
    }

}
