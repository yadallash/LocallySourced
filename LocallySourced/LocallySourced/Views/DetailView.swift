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
    
    lazy var marketNameLabel: UILabel =  {
        let label = UILabel()
        label.setContentHuggingPriority(UILayoutPriority(252), for: .vertical)
        label.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .vertical)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 20)
        //to do - set up font, color, etc.
        return label
    }()

    lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.mapType = .standard
//        mapView.isScrollEnabled = false
//        mapView.isZoomEnabled = false
        mapView.isPitchEnabled = false
//        mapView.isUserInteractionEnabled = false
        mapView.setContentHuggingPriority(UILayoutPriority(253), for: .vertical)
        mapView.setContentCompressionResistancePriority(UILayoutPriority(249), for: .vertical)
        return mapView
    }()
    
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(UILayoutPriority(249), for: .vertical)
        label.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .vertical)
        label.numberOfLines = 0
        //to do - set up font, color, etc.
        return label
    }()
    
    lazy var directionsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Directions", for: .normal)
        //to do - set up font, color, look
        button.setTitleColor(UIColor.buttonBlue, for: .normal)
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
        setUpMarketNameLabel()
        setUpMapView()
        setUpAddressLabel()
        setUpDirectionsButton()
    }
    
    private func setUpMarketNameLabel() {
        addSubview(marketNameLabel)
        
        marketNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(20)
            make.leading.trailing.equalTo(self).inset(20)
        }
    }
    
    private func setUpMapView() {
        addSubview(mapView)
        
        mapView.snp.makeConstraints { (make) in
            make.top.equalTo(marketNameLabel.snp.bottom).offset(20)
            make.width.equalTo(self.snp.width).multipliedBy(0.80)
            make.centerX.equalTo(self)
            make.height.lessThanOrEqualTo(self).multipliedBy(0.5)
        }
        
        mapView.layer.masksToBounds = true
        mapView.layer.borderWidth = 1.0
        mapView.layer.borderColor = UIColor.lightGray.cgColor
        mapView.layer.cornerRadius = 10
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
            make.height.equalTo(self).multipliedBy(0.10)
            make.top.equalTo(addressLabel.snp.bottom).offset(20)
            make.centerX.equalTo(self)
            make.bottom.equalTo(self).offset(-20)
        }
        
        directionsButton.layer.masksToBounds = true
        directionsButton.layer.cornerRadius = 10
        directionsButton.layer.borderWidth = 1.0
        directionsButton.layer.borderColor = UIColor.buttonBlue.cgColor
    }
}
