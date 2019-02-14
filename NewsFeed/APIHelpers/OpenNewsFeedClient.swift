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
            let decodedData = decodeJSON(data: response)
            parseNewsFeed(json : decodedData!)
        }
    }
    
}
func parseNewsFeed(json: [String: AnyObject?]) {
    var posts : [NewsPost] = []
//    var k = json["totalResults"] as! Int
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

//            print(post.source + "\n")
//            print(post.author + "\n")
//            print(post.title + "\n")
//            print(post.descript + "\n")
//            print(post.url + "\n")
//            print(post.imageUrl + "\n")
//            print(post.publishedAt + "\n")
            posts.append(post)
        }
    } else {
        print("not a [[nsdict]]")
    }
}
func decodeJSON(data: Data) -> [String:AnyObject]? {
    
    do {
        let result = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:AnyObject]
        return result
    }
    catch {
        print("FAIL")
        return nil
    }
}
