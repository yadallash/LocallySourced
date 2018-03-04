//
//  TestFavoriteTableViewController.swift
//  LocallySourced
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 TeamLocallySourced. All rights reserved.
//

import UIKit
import FoldingCell
class TestFavoriteTableViewController: UITableViewController {
    let kCloseCellHeight: CGFloat = 179
    let kOpenCellHeight: CGFloat = 488
    var kRowsCount = 10
    var cellHeights: [CGFloat] = []
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
            self.tableView.reloadData()
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
        FileManagerHelper.manager.loadSavedFarmersMarket()
        self.favoritFarmersMarkets = FileManagerHelper.manager.retrieveSavedFarmersMarket()
        configNavBar()
        setupCells()
        
    }
    private func setupCells() {
        cellHeights = Array(repeating: kCloseCellHeight, count: marketsByBouroghs.count)
        kRowsCount = favoritFarmersMarkets.count
        tableView.estimatedRowHeight = kCloseCellHeight
        tableView.rowHeight = UITableViewAutomaticDimension
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
                FileManagerHelper.manager.addNewFarmersMarket(markets[10])
            }
        }
        FarmersMarketAPIClient.manager.getMarkets(completion: {markets = $0}, errorHandler: {print($0)})
    }
    

    static func storyBoardInstance()-> TestFavoriteTableViewController{
        //this will intialize a storyBoard with name notice that it be anything like "main" or whatever name is the file name is
        let storyBoard = UIStoryboard(name: "TestFav", bundle: nil)
        let testFavoriteTableViewController = storyBoard.instantiateViewController(withIdentifier: "TestFavoriteTableViewController") as! TestFavoriteTableViewController
        return testFavoriteTableViewController
    }

}
    // MARK: - Table view data source
extension TestFavoriteTableViewController{
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return marketsByBouroghs.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return (marketsByBouroghs[sectionKey[section]]?.count) ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "FoldingCell", for: indexPath) as! TestFavoriteTableViewCell
        
        let durations: [TimeInterval] = [0.25, 0.2 , 0.2]
        cell.durationsForExpandedState = durations
        cell.durationsForCollapsedState = durations
        guard let marketPlaces = marketsByBouroghs[sectionKey[indexPath.section]] else{ return cell}
//        cell.marketTitle.text = marketPlaces[indexPath.row].facilityname
        return cell
    }
}

//MARK: tableView Delegate
extension TestFavoriteTableViewController{
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) as? TestFavoriteTableViewCell else{
            return
        }
        
        if cell.isAnimating() {
            return
        }
        
        var duration = 0.0
        let cellIsCollapsed = cellHeights[indexPath.row] == kCloseCellHeight
        if cellIsCollapsed {
            cellHeights[indexPath.row] = kOpenCellHeight
            cell.unfold(true, animated: true, completion: nil)
            duration = 0.5
        } else {
            cellHeights[indexPath.row] = kCloseCellHeight
            cell.unfold(false, animated: true, completion: nil)
            duration = 0.8
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            
            guard case let cell as TestFavoriteTableViewCell = cell else{
                return
        }
        cell.backgroundColor = .clear
        if cellHeights[indexPath.row] == kCloseCellHeight {
            cell.unfold(false, animated: false, completion: nil)
        } else {
            cell.unfold(true, animated: false, completion: nil)
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    
}

