//
//  ShoppingListsViewController.swift
//  LocallySourced
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 TeamLocallySourced. All rights reserved.
//

import UIKit

class ShoppingListsViewController: UIViewController {
    
    let listView = ShoppingListsView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        constrainView()
    }

    private func constrainView() {
        view.addSubview(listView)
        listView.snp.makeConstraints { (view) in
            view.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    

}
