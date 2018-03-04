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
    var shoppingList = [List]() {
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
        listView.listTableView.dataSource = self
        constrainView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        shoppingList = FileManagerHelper.manager.retrieveSavedShoppingLists()
    }

    private func constrainView() {
        view.addSubview(listView)
        listView.snp.makeConstraints { (view) in
            view.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    @objc private func addList() {
            let alert = UIAlertController(title: "Create a List", message: nil, preferredStyle: .alert)
            alert.addTextField { (textField) in
                textField.placeholder = "Enter a Name for the List"
            }
            alert.addAction(UIAlertAction(title: "Done", style: .default) { [weak alert](_) in
                let textField = alert?.textFields![0].text
                let list = List(title: textField!, items: [])
                guard FileManagerHelper.manager.alreadySavedShoppingList(list) == false else {self.errorAlert(); return}
                FileManagerHelper.manager.addNewShoppingList(list)
                self.shoppingList.append(list)
                self.listView.listTableView.reloadData()
            })
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
    }
    func errorAlert() {
        let alertController = UIAlertController(title: "Error", message: "List already exists", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (alert) in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
extension ShoppingListsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)
        let list = shoppingList[indexPath.row]
        cell.textLabel?.text = list.title
        return cell
    }
    
}
extension ShoppingListsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { (action, view, handler) in
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            
                handler(true)
            }
        deleteAction.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true //HERE..
        return configuration
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, handler) in
            handler(true)
        }
        editAction.backgroundColor = .lightGray
        let configuration = UISwipeActionsConfiguration(actions: [editAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
}


