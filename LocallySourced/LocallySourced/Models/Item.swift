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
    let completed: Bool
    init(name: String, amount: Int, completed: Bool) {
        self.name = name
        self.amount = amount
        self.completed = completed
    }
}
