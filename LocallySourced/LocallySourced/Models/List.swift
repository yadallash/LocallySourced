//
//  List.swift
//  LocallySourced
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 TeamLocallySourced. All rights reserved.
//

import Foundation
class List: Codable {
    let title: String
    var items: [Item]
    init(title: String, items: [Item]) {
        self.title = title
        self.items = items
    }
}
