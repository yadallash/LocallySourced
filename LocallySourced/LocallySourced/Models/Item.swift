//
//  Item.swift
//  LocallySourced
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 TeamLocallySourced. All rights reserved.
//

import Foundation
class Item: Codable {
    let name: String
    let amount: Int
    init(name: String, amount: Int) {
        self.name = name
        self.amount = amount
    }
}
