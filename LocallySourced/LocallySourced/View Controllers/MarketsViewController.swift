//
//  ViewController.swift
//  LocallySourced
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 TeamLocallySourced. All rights reserved.
//

import UIKit
import SnapKit

class MarketsViewController: UIViewController {
    
    let marketView = MarketsView()
    
    public var markets = [FarmersMarket]() {
        didSet {
            animateMarketTV()
        }
    }
    var filteredMarkets: [FarmersMarket] {
        guard filteredByCity != "All" else {return markets}
        if let city = filteredByCity {
            return markets.filter{
                guard let filteredCity = $0.facilitycity else {return false}
                if filteredCity.rawValue == city {
                    return true
                }
                return false
            }
        } else {
            return markets
        }
    }
    var filteredByCity: String?
    
    var cities = [Facilitycity.bronx.rawValue, Facilitycity.brooklyn.rawValue, Facilitycity.manhattan.rawValue, Facilitycity.queens.rawValue, Facilitycity.statenIsland.rawValue, "All"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
        navigationController?.title = "Access Green"
        marketView.buttonTableView.dataSource = self; marketView.buttonTableView.delegate = self
        marketView.marketTableView.dataSource = self; marketView.marketTableView.delegate = self
        constrainView()
        buttonSetup()
        loadMarkets()
    }
    private func constrainView() {
        view.addSubview(marketView)
        marketView.snp.makeConstraints { (view) in
            view.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    private func buttonSetup() {
        marketView.filterButton.addTarget(self, action: #selector(filterButtonPressed), for: .touchUpInside)
    }
    @objc private func filterButtonPressed() {
        if marketView.buttonTableView.isHidden == true {
            marketView.buttonTableView.isHidden = false
            animateDropdownTV()
        } else {
            marketView.buttonTableView.isHidden = true
        }
    }
    
    private func loadMarkets() {
        FarmersMarketAPIClient.manager.getMarkets(completion: {self.markets = $0}, errorHandler: {print($0)})
    }
    
    private func animateMarketTV() {
        marketView.marketTableView.reloadData()
        let cells = marketView.marketTableView.visibleCells
        let tableViewHeight = marketView.marketTableView.bounds.size.height
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
    
    private func animateDropdownTV() {
        marketView.buttonTableView.reloadData()
        let cells = marketView.buttonTableView.visibleCells
        let tableViewHeight = marketView.buttonTableView.bounds.size.height
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: -50, y: -tableViewHeight)
        }
        var delayCounter:Double = 0
        for cell in cells {
            UIView.animate(withDuration: 1.75, delay: delayCounter * 0.05, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 0.5
        }
    }

}
extension MarketsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case marketView.buttonTableView:
            marketView.filterButton.setTitle(cities[indexPath.row], for: .normal)
            self.filteredByCity = self.marketView.filterButton.titleLabel?.text
            marketView.buttonTableView.isHidden = true
            animateMarketTV()
//            self.marketView.marketTableView.reloadData()
        case marketView.marketTableView:
            let market = markets[indexPath.row]
            let detailVC = DetailViewController(market: market)
            navigationController?.pushViewController(detailVC, animated: true)
        default:
            break
        }
    }
}
extension MarketsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case marketView.buttonTableView:
            return cities.count
        case marketView.marketTableView:
            return filteredMarkets.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case marketView.buttonTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath)
            let city = cities[indexPath.row]
            cell.textLabel?.text = city
            return cell
        case marketView.marketTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MarketCell", for: indexPath) as! MarketCell
            let market = filteredMarkets[indexPath.row]
            cell.marketName.text = market.facilityname
            cell.marketCity.text = market.facilitycity?.rawValue
            return cell
        default:
            return UITableViewCell()
        }
    }
    
}

