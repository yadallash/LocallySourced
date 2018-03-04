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
    var shoppingList = [String]() {
        didSet {
            DispatchQueue.main.async {
                self.listView.listTableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addList))
        listView.listTableView.delegate = self
        constrainView()
    }

    private func constrainView() {
        view.addSubview(listView)
        listView.snp.makeConstraints { (view) in
            view.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    @objc private func addList() {
        func showAlert() {
            let alert = UIAlertController(title: "Category", message: nil, preferredStyle: .alert)
            alert.addTextField { (textField) in
                textField.placeholder = "Enter a Name for the List"
            }
            alert.addAction(UIAlertAction(title: "Done", style: .default) { [weak alert](_) in
                
            })
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
        }
    }
}
extension ShoppingListsViewController: UITableViewDelegate {
    
}
