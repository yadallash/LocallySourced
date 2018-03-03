//
//  ViewController.swift
//  LocallySourced
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 TeamLocallySourced. All rights reserved.
//

import UIKit

class MarketsViewController: UIViewController {
    
    let marketView = MarketsView()
    
    public var markets = [FarmersMarket]() {
        didSet {
            self.marketView.marketTableView.reloadData()
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
    var filteredByCity: String? {
        didSet {
            self.marketView.marketTableView.reloadData()
        }
    }
    
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
            marketView.buttonTableView.snp.makeConstraints { (make) in
                make.height.equalTo(self.marketView).multipliedBy(0.4)
            }
            marketView.buttonTableView.isHidden = false
        } else {
            marketView.buttonTableView.isHidden = true
        }
    }
    
    private func loadMarkets() {
        FarmersMarketAPIClient.manager.getMarkets(completion: {self.markets = $0}, errorHandler: {print($0)})
    }

}
extension MarketsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case marketView.buttonTableView:
            marketView.filterButton.setTitle(cities[indexPath.row], for: .normal)
            self.filteredByCity = self.marketView.filterButton.titleLabel?.text
            marketView.buttonTableView.isHidden = true
            self.marketView.marketTableView.reloadData()
        case marketView.marketTableView:
            navigationController?.pushViewController(DetailViewController(), animated: true)
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

