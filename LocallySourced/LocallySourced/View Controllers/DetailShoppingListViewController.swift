//
//  DetailShoppingListViewController.swift
//  LocallySourced
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 TeamLocallySourced. All rights reserved.
//

import UIKit

class DetailShoppingListViewController: UIViewController {
    
    // MARK: - Properties
    private var detailShoppingListView = DetailShoppingListView()
    private let resusableCell = "ItemCell"
    private var shoppingList: List! {
        didSet {
            DispatchQueue.main.async {
                self.detailShoppingListView.shoppingListTableView.reloadData()
            }
        }
    }
    
    // MARK: - Init (Dependency injection)
    init(list: List){
        self.shoppingList = list
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // Mark: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        detailShoppingListView.shoppingListTableView.delegate = self
        detailShoppingListView.shoppingListTableView.dataSource = self
        configureNavBar()
        self.view.addSubview(detailShoppingListView)
        self.view.backgroundColor = .red
    }
    
    // MARK: - Functions
    private func toggleCellCheckbox(_ cell: ItemCell, isCompleted: Bool) {
        if !isCompleted {
            cell.itemLabel.textColor = UIColor.black
            cell.stepperValueLabel.textColor = UIColor.black
            cell.stepperButton.tintColor = UIColor.black
            cell.stepperButton.isEnabled = true
            cell.checkMarkImageView.image = #imageLiteral(resourceName: "unchecked")
        } else {
            cell.itemLabel.textColor = UIColor.gray
            cell.stepperValueLabel.textColor = UIColor.gray
            cell.stepperButton.tintColor = UIColor.gray
            cell.stepperButton.isEnabled = false
            cell.checkMarkImageView.image = #imageLiteral(resourceName: "checked")
        }
    }
    
    private func configureNavBar() {
        navigationItem.title = shoppingList.title
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.black
    }
    
    // adds items to shoppingList, via alertController
    @objc private func addItem() {
        let alert = UIAlertController(title: "Grocery Item", message: "Add an Item", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] action in
            let textField = alert.textFields![0]
            let item = Item(name: textField.text!, amount: 0, completed: false)
            let _ = FileManagerHelper.manager.addItem(item, toShoppingList: self!.shoppingList)
            self?.detailShoppingListView.shoppingListTableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
}

// MARK: - UITableViewDataSource
extension DetailShoppingListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: resusableCell, for: indexPath) as! ItemCell
        let item = shoppingList.items[indexPath.row]
        cell.configureCell(with: item)
        cell.delegate = self
        toggleCellCheckbox(cell, isCompleted: item.completed)
        return cell
    }
    
    // defines tableView editing style. Set to .delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            FileManagerHelper.manager.removeItem(shoppingList.items[indexPath.row], fromShoppingList: self.shoppingList)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

// MARK: - UITableViewDelegate
extension DetailShoppingListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? ItemCell else { return }
        let groceryItem = shoppingList.items[indexPath.row]
        groceryItem.completed = !groceryItem.completed
        FileManagerHelper.manager.updateItem(groceryItem, forShoppingList: self.shoppingList)
        toggleCellCheckbox(cell, isCompleted: groceryItem.completed)
        tableView.reloadData()
    }
    
}

extension DetailShoppingListViewController: ItemCellDelegate {
    func stepperButtonPressed(item: Item) {
        FileManagerHelper.manager.updateItem(item, forShoppingList: shoppingList)
    }
}
