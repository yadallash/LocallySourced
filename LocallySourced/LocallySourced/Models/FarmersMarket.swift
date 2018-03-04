//
//  FarmersMarket.swift
//  LocallySourced
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 TeamLocallySourced. All rights reserved.
//

import Foundation

enum Facilitycity: String, Codable {
    case bronx = "Bronx"
    case brooklyn = "Brooklyn"
    case manhattan = "Manhattan"
    case queens = "Queens"
    case statenIsland = "Staten Island"
}
class FarmersMarket: Codable {
    let facilityaddinfo: String?
    let facilitycity: Facilitycity?
    let facilityname: String
    let facilitystate: String
    let facilitystreetname: String?
    let facilityzipcode: String?
    let latitude: String
    let longitude: String
    var notes: String? = "You can add some notes here:"
}


