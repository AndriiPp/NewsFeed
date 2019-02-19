//
//  OpenNewsFeedClient.swift
//  NewsFeed
//
//  Created by Andrii Pyvovarov on 2/14/19.
//  Copyright © 2019 Andrii Pyvovarov. All rights reserved.
//

import Foundation

class OpenNewsFeedClient {
     func requestFeed(completionHandler: @escaping ([NewsPost]) -> ()){
        //set up variables
        let baseURL = "https://newsapi.org/v2/top-headlines"
        let categoryString : String = "sports"
        let countryString : String = "ua"
        // Set up resource
        let requestResource = Resource(baseURL: baseURL,  countryString: countryString, categoryString: categoryString, method: Method.GET) { (response) -> Data? in
            return(response)
        }
        let requestClient = HTTPClient()
        requestClient.apiRequest(resource: requestResource, failure: { (response, data) in
            print(response)
            
        }) { (response) in
            let decodedData = self.decodeJSON(data: response)
            let newsPosts = self.parseNewsFeed(json : decodedData!)
            completionHandler(newsPosts)
        }
    }
    private func parseNewsFeed(json: [String: AnyObject?]) -> [NewsPost] {
        
        var posts : [NewsPost] = []
        if let feedList = json["articles"] as? [NSDictionary]{
            
            for i in feedList {
                let myI = i as? [String: AnyObject]
                let source : String
                let author : String
                let title : String
                let description : String
                let url : String
                let imageUrl : String
                let publishedAt : String

               ((myI!["source"]!["name"] as? String) != nil) ? (source = "source: " + (myI!["source"]!["name"] as! String)) :  (source = "source: ")
                ((myI!["author"] as? String) != nil ) ? (author = "author: " + (myI!["author"] as! String)) : (author = "author: ")
                ((myI!["title"] as? String) != nil) ? (title = (myI!["title"] as! String)) : (title = " ")
                ((myI!["description"] as? String ) != nil) ? (description = (myI!["description"] as! String )) : (description = " ")
                ((myI!["url"] as? String) != nil) ? (url = (myI!["url"] as! String)) : (url = " ")
                ((myI!["urlToImage"] as? String) != nil) ? (imageUrl = (myI!["urlToImage"] as! String)) : (imageUrl = " ")
                ((myI!["publishedAt"] as? String) != nil) ? (publishedAt = (myI!["publishedAt"] as! String)) : (publishedAt = " ")

                
                let post = NewsPost(source: source, author : author, title: title, descript: description , publishedAt: publishedAt , url: url , imageUrl: imageUrl)
                posts.append(post)
            }
        } else {
            print("not a [[nsdict]]")
        }
        //    print(posts)
        return posts
    }

    private func decodeJSON(data: Data) -> [String:AnyObject]? {
        
        do {
            let result = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:AnyObject]
            return result
        }
        catch {
            print("FAIL")
            return nil
        }
    }

    
}
