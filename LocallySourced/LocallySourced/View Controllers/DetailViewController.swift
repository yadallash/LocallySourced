//
//  DetailViewController.swift
//  LocallySourced
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 TeamLocallySourced. All rights reserved.
//

import UIKit
import SnapKit
import MapKit

class DetailViewController: UIViewController {

    private lazy var detailView = DetailView(frame: self.view.safeAreaLayoutGuide.layoutFrame)
    
    private var market = FarmersMarket()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    init(market: FarmersMarket) {
        self.market = market
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpNavigation()
    }
    
    private func setUpViews() {
        self.view.addSubview(detailView)
        detailView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        detailView.marketNameLabel.text = market.facilityname
        detailView.addressLabel.text = "\(market.facilitystreetname ?? "No Street Name Available"), \(market.facilitycity?.rawValue ?? "No City Name Available"), \(market.facilitystate), \(market.facilityzipcode ?? "No Zipcode Available")"
        if let latitude = Double(market.latitude), let longitude = Double(market.longitude) {
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let region = MKCoordinateRegionMakeWithDistance(coordinate, 400, 400)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            detailView.mapView.addAnnotation(annotation)
            detailView.mapView.setRegion(region, animated: false)
        }
        
        detailView.directionsButton.addTarget(self, action: #selector(directionsButtonTapped), for: .touchUpInside)
        detailView.yelpButton.addTarget(self, action: #selector(yelpButtonTapped), for: .touchUpInside)
    }
    
    private func setUpNavigation() {
        var heartImage: UIImage?
        let alreadySaved = FileManagerHelper.manager.alreadySavedFarmersMarket(market)
        //if not favorited
        if alreadySaved {
            heartImage = UIImage(named: "fillHeartIcon")?.withRenderingMode(.alwaysOriginal)
        } else { //if favorited
            heartImage = UIImage(named: "unfillHeartIcon")?.withRenderingMode(.alwaysOriginal)
        }
        
        let saveBarButtonItem = UIBarButtonItem(image: heartImage, style: UIBarButtonItemStyle.plain, target: self, action: #selector(saveMarket(sender:)))
        let addItemBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "shoppingIcon"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(addItemToShoppingList))
        self.navigationItem.rightBarButtonItems = [saveBarButtonItem, addItemBarButtonItem]
    }
    
    @objc private func saveMarket(sender: UIBarButtonItem) {
        //to do - add to saving with file manager
        print("save item!!")
        let heartUnfilled = UIImage(named: "unfillHeartIcon")?.withRenderingMode(.alwaysOriginal)
        let heartFilled = UIImage(named: "fillHeartIcon")?.withRenderingMode(.alwaysOriginal)
        
        if sender.image == heartFilled {
            sender.image = heartUnfilled
            //to do - remove from favorites
            FileManagerHelper.manager.removeFarmersMarket(market)
        } else {
            sender.image = heartFilled
            //to do - add to favorites
            FileManagerHelper.manager.addNewFarmersMarket(market)
        }
    }
    
    @objc private func addItemToShoppingList() {
        //to do - add to saving with shopping list
        print("add item!!")
    }
    
    @objc private func directionsButtonTapped() {
        print("directions button tapped!!")
    }
    
    @objc private func yelpButtonTapped() {
        print("yelp button tapped!!")
    }

}
