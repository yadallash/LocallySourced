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
    
    var shoppingList = [GroceryItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
