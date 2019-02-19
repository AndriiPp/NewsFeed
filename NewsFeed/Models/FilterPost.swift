//
//  filterKey.swift
//  NewsFeed
//
//  Created by AndriiPp on 2/19/19.
//  Copyright © 2019 Andrii Pyvovarov. All rights reserved.
//

import Foundation

class FilterPost{
    var country : String = "ua"
    var category : String = "sports"
    init(country : String, category : String) {
        self.country = country
        self.category = category
    }
}
