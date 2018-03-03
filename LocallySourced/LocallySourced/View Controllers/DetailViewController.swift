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
    }
    
    private func setUpViews() {
        detailView.mapView.delegate = self
        
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
    }

}

extension DetailViewController: MKMapViewDelegate {
    
}
