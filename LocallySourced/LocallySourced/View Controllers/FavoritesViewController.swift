//
//  FavoriteViewController.swift
//  LocallySourced
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 TeamLocallySourced. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    let favoriteView = FavoritesView()
    var favoritFarmersMarkets = [FarmersMarket](){
        didSet{
            self.favoriteView.favoriteTableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.favoriteView.favoriteTableView.dataSource = self
        self.favoriteView.favoriteTableView.delegate = self
        setupFavoriteView()
        configNavBar()
        FileManagerHelper.manager.loadSavedFarmersMarket()
        self.favoritFarmersMarkets = FileManagerHelper.manager.retrieveSavedFarmersMarket()
    }
    
    func setupFavoriteView(){
        view.addSubview(favoriteView)
        favoriteView.snp.makeConstraints { (constraint) in
            constraint.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
    }
    func configNavBar(){
        let listNavBarButtonItem = UIBarButtonItem(title: "testButton", style: .done, target: self, action: #selector(addListTest(_:)))
        //            self.navigationItem.titleView = imageView
        navigationItem.rightBarButtonItems = [listNavBarButtonItem]
        navigationItem.title = "Title"
    }
    @objc func addListTest(_ sender: UIBarButtonItem){
        var markets = [FarmersMarket](){
            didSet{
                FileManagerHelper.manager.addNewFarmersMarket(markets[0])
            }
        }
        FarmersMarketAPIClient.manager.getMarkets(completion: {markets = $0}, errorHandler: {print($0)})
    }
    

}
//MARK: - tableView dataSource
extension FavoritesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritFarmersMarkets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let marketSetup = favoritFarmersMarkets[indexPath.count]
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath)
        cell.textLabel?.text = marketSetup.facilityname
        return cell
    }
    
    
}
//MARK: - tableView delegates
extension FavoritesViewController: UITableViewDelegate{
    
}
