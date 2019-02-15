//
//  NewsPost.swift
//  NewsFeed
//
//  Created by Andrii Pyvovarov on 2/14/19.
//  Copyright © 2019 Andrii Pyvovarov. All rights reserved.
//

import Foundation

class NewsPost  {
    var source : String
    var author : String
    var title : String
    var descript: String
    var publishedAt : String
    var url : String
    var imageUrl : String
        init(source : String, author : String, title : String, descript : String, publishedAt : String, url : String, imageUrl : String) {
            self.source = source
            self.author = author
            self.title = title
            self.descript = descript
            self.publishedAt = publishedAt
            self.url = url
            self.imageUrl = imageUrl
        }
}
