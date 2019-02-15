//
//  OpenNewsFeedClient.swift
//  NewsFeed
//
//  Created by Andrii Pyvovarov on 2/14/19.
//  Copyright © 2019 Andrii Pyvovarov. All rights reserved.
//

import Foundation

class OpenNewsFeedClient {
     let key:String = "3ce4f4731af54458b4aaec0a58d1f644"
     func requestFeed(completionHandler: @escaping ([NewsPost]) -> ()){
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
            let decodedData = self.decodeJSON(data: response)
            let newsPosts = self.parseNewsFeed(json : decodedData!)
            completionHandler(newsPosts)
        }
    }
    private func parseNewsFeed(json: [String: AnyObject?]) -> [NewsPost] {
        //   var k = json["totalResults"] as! Int
        
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
                if  (myI!["source"]!["name"] as? String) != nil{
                    source = "source: " + (myI!["source"]!["name"] as! String)
                } else {
                    source = "source: "
                }
                if (myI!["author"] as? String) != nil {
                    author = "author: " + (myI!["author"] as! String)
                } else {
                    author = "author: "
                }
                if (myI!["title"] as? String) != nil {
                    title = (myI!["title"] as! String)
                } else {
                    title = " "
                }
                if (myI!["description"] as? String ) != nil {
                    description = (myI!["description"] as! String )
                } else {
                    description = " "
                }
                if (myI!["url"] as? String) != nil {
                    url = (myI!["url"] as! String)
                } else  {
                    url = " "
                }
                if (myI!["urlToImage"] as? String) != nil {
                    imageUrl = (myI!["urlToImage"] as! String)
                } else {
                    imageUrl = " "
                }
                if (myI!["publishedAt"] as? String) != nil {
                    publishedAt = (myI!["publishedAt"] as! String)
                } else {
                    publishedAt = " "
                }
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
