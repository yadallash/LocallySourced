//
//  DetailView.swift
//  LocallySourced
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 TeamLocallySourced. All rights reserved.
//

import UIKit
import MapKit
import SnapKit

class DetailView: UIView {

    lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.isScrollEnabled = false
        mapView.isZoomEnabled = false
        mapView.isPitchEnabled = false
        mapView.isUserInteractionEnabled = false
        return mapView
    }()
    
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        //to do - set up font, color, etc.
        return label
    }()
    
    lazy var directionsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Directions", for: .normal)
        //to do - set up font, color, look
        return button
    }()
    
    lazy var yelpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Yelp", for: .normal)
        //to do - set up font, color, look
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white
        setUpViews()
    }
    
    private func setUpViews() {
        setUpMapView()
        setUpAddressLabel()
        setUpDirectionsButton()
        setUpYelpButton()
    }
    
    private func setUpMapView() {
        addSubview(mapView)
        
        mapView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(20)
            make.width.equalTo(self.snp.width).multipliedBy(0.80)
            make.centerX.equalTo(self)
        }
    }
    
    private func setUpAddressLabel() {
        addSubview(addressLabel)
        
        addressLabel.snp.makeConstraints { (make) in
            make.top.equalTo(mapView.snp.bottom).offset(20)
            make.width.equalTo(self).multipliedBy(0.7)
            make.centerX.equalTo(self)
        }
    }
    
    private func setUpDirectionsButton() {
        addSubview(directionsButton)
        
        directionsButton.snp.makeConstraints { (make) in
            make.width.equalTo(self).multipliedBy(0.50)
            make.top.equalTo(addressLabel).offset(20)
            make.centerX.equalTo(self)
        }
    }
    
    private func setUpYelpButton() {
        addSubview(yelpButton)
        
        yelpButton.snp.makeConstraints { (make) in
            make.width.equalTo(directionsButton)
            make.top.equalTo(directionsButton).offset(10)
            make.centerX.equalTo(<#T##other: ConstraintRelatableTarget##ConstraintRelatableTarget#>)
        }
    }
    
}
