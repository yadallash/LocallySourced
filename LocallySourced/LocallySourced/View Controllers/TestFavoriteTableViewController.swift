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
    var kCloseCellHeight: CGFloat = 179
    let kOpenCellHeight: CGFloat = 488
    var kRowsCount = 10
    var cellHeights: [[CGFloat]] = [[]]
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
    private func animateMarketTV() {
        tableView.reloadData()
        let cells = tableView.visibleCells
        let tableViewHeight = tableView.bounds.size.height
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: -tableViewHeight - 25)
        }
        var delayCounter:Double = 0
        for cell in cells {
            UIView.animate(withDuration: 1.75, delay: delayCounter * 0.05, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 0.5
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
        FileManagerHelper.manager.loadSavedFarmersMarket()
        self.favoritFarmersMarkets = FileManagerHelper.manager.retrieveSavedFarmersMarket()
        configNavBar()
        setupCells()
        
    }
    private func setupCells() {
        kCloseCellHeight = self.view.bounds.height*0.25
        cellHeights = Array(repeating: [kCloseCellHeight], count: sectionKey.count)
        for i in 0..<sectionKey.count{
            let arrayOfMarkets = marketsByBouroghs[sectionKey[i]]
            cellHeights[i] = Array(repeating: kCloseCellHeight, count: arrayOfMarkets!.count)
        }
        kRowsCount = favoritFarmersMarkets.count
        tableView.estimatedRowHeight = kCloseCellHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        animateMarketTV()
        tableView.separatorColor = .clear
    }
    func configNavBar(){
        navigationItem.title = "Access Green"
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
        return sectionKey.count
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionKey[section]
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
        let marketSetup = marketPlaces[indexPath.row]
        cell.setupCell(from: marketSetup)
        cell.delegate = self
        cell.foregroundMask.layer.opacity = 0.25
        cell.containerMask.layer.opacity = 0.35
        cell.indexPath = indexPath
        if indexPath.row % 2 == 0{
            cell.marketImageForegroundContainer.image = #imageLiteral(resourceName: "farmersMarket4")
            cell.containerMarketImage.image = #imageLiteral(resourceName: "farmersMarket4")
        }else{
            cell.marketImageForegroundContainer.image = #imageLiteral(resourceName: "farmersMarket3")
            cell.containerMarketImage.image = #imageLiteral(resourceName: "farmersMarket3")
        }
        cell.farmersMarket = marketSetup
        return cell
    }
}

//MARK: tableView Delegate
extension TestFavoriteTableViewController: FavoriteTableViewCellDelegate{
    func submitButtonPressed(sender cell: TestFavoriteTableViewCell) {
        guard let market = cell.farmersMarket, let indexPath = cell.indexPath else {
            return
        }
        animatingFoldingCell(for: cell, indexPath: indexPath)
        if let notes = cell.noteTextView.text {
            market.notes = notes
            FileManagerHelper.manager.updateFarmersMarket(market, withNewNotes: notes)
        }
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) as? TestFavoriteTableViewCell else{
            return
        }
        
      animatingFoldingCell(for: cell, indexPath: indexPath)
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            
            guard case let cell as TestFavoriteTableViewCell = cell else{
                return
        }
        cell.backgroundColor = .clear
        if cellHeights[indexPath.section][indexPath.row] == kCloseCellHeight {
            cell.unfold(false, animated: false, completion: nil)
        } else {
            cell.unfold(true, animated: false, completion: nil)
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.section][indexPath.row]
    }
   private func animatingFoldingCell(for cell: TestFavoriteTableViewCell, indexPath: IndexPath){
          cell.noteTextView.resignFirstResponder()
        if cell.isAnimating() {
            return
        }
        var duration = 0.0
        let cellIsCollapsed = cellHeights[indexPath.section][indexPath.row] == kCloseCellHeight
        if cellIsCollapsed {
            cellHeights[indexPath.section][indexPath.row] = kOpenCellHeight
            cell.unfold(true, animated: true, completion: nil)
            duration = 0.5
        } else {
            cellHeights[indexPath.section][indexPath.row] = kCloseCellHeight
            cell.unfold(false, animated: true, completion: nil)
            duration = 0.8
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }, completion: nil)
    }

}


