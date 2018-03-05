//
//  FavoriteViewController.swift
//  LocallySourced
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 TeamLocallySourced. All rights reserved.
//

import UIKit
import FoldingCell
class FavoritesViewController: UIViewController {

    lazy var favoriteView = FavoritesView()
    var favoritFarmersMarkets = [FarmersMarket]() {
        didSet{
            for market in favoritFarmersMarkets{
                if marketsByBouroghs[(market.facilitycity?.rawValue)!] != nil {
                    marketsByBouroghs[(market.facilitycity?.rawValue)!]?.append(market)
                }else{
                    marketsByBouroghs[(market.facilitycity?.rawValue)!] = [market]
                }
            }
//            self.favoriteView.favoriteTableView.reloadData()
        }
    }

    var marketsByBouroghs = [String: [FarmersMarket]](){
        didSet{
            for (key,value) in marketsByBouroghs{
                print("Bourogh: \(key), and markets: \(value)")
            }
        }
    }
    
    var sectionKey: [String] {
        var arr: [String] = []
        for (key, _) in marketsByBouroghs {
            arr.append(key)
        }
        return arr
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
//        let listNavBarButtonItem = UIBarButtonItem(title: "testButton", style: .done, target: self, action: #selector(addListTest(_:)))
//        //            self.navigationItem.titleView = imageView
//        navigationItem.rightBarButtonItems = [listNavBarButtonItem]
//        navigationItem.title = "Title"
        self.navigationController?.isNavigationBarHidden = true
    }
    @objc func addListTest(_ sender: UIBarButtonItem){
        var markets = [FarmersMarket](){
            didSet{
                FileManagerHelper.manager.addNewFarmersMarket(markets[10])
            }
        }
        FarmersMarketAPIClient.manager.getMarkets(completion: {markets = $0}, errorHandler: {print($0)})
    }
    

}
//MARK: - tableView dataSource
extension FavoritesViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return marketsByBouroghs.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (marketsByBouroghs[sectionKey[section]]?.count) ?? 0
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionKey[section]
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as? FavoriteTableViewCell else{
            return UITableViewCell()
        }
        
        guard let marketPlaces = marketsByBouroghs[sectionKey[indexPath.section]] else{ return cell}
        cell.detailView.marketNameLabel.text = marketPlaces[indexPath.row].facilityname
        return cell
    }
    
    
}
//MARK: - tableView delegates
extension FavoritesViewController: UITableViewDelegate{
    

}

