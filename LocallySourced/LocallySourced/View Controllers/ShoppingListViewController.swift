//
//  ShoppingListViewController.swift
//  LocallySourced
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 TeamLocallySourced. All rights reserved.
//

import UIKit

struct GroceryItem {
    
    let name: String
    var completed: Bool
    
    init(name: String, completed: Bool) {
        self.name = name
        self.completed = completed
    }
}

class ShoppingListViewController: UIViewController {
    
    // MARK: - Properties
    var shoppingListView = ShoppingListView()
    var shoppingList = [GroceryItem]() {
        didSet {
            DispatchQueue.main.async {
                self.shoppingListView.shoppingListTableView.reloadData()
            }
        }
    }
    
    // Mark: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    
}
