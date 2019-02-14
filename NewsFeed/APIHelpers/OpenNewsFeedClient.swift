//
//  OpenNewsFeedClient.swift
//  NewsFeed
//
//  Created by Andrii Pyvovarov on 2/14/19.
//  Copyright © 2019 Andrii Pyvovarov. All rights reserved.
//

import Foundation

class OpenNewsFeedClient {
    static var key:String = "3ce4f4731af54458b4aaec0a58d1f644"
    private var posts : [NewsPost] = []
    static func requestFeed(){
        //set up variables
        let baseURL = "https://newsapi.org/v2/top-headlines"
        let queryString = "?country=ua&apiKey=\(key)"
        // Set up resource
        let requestResource = Resource(baseURL: baseURL,  queryString: queryString, method: Method.GET) { (response) -> Data? in
            return(response)
        }
        let requestClient = HTTPClient()
        requestClient.apiRequest(resource: requestResource, failure: { (response, data) in
            print(response)
            
        }) { (response) in
            
        }
    }
}
