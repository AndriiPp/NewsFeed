//
//  HTTPClient.swift
//  NewsFeed
//
//  Created by Andrii Pyvovarov on 2/14/19.
//  Copyright © 2019 Andrii Pyvovarov. All rights reserved.
//

import Foundation

enum Method: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

struct Resource<A> {
    let baseURL: String
    let countryString: String
    let categoryString : String
    let method : Method
    let parse: (Data) -> A?
}

enum Reason {
    case couldNotParseJSON
    case noData
    case noSuccessStatusCode(statusCode: Int)
    case other(NSError)
}

struct HTTPClient {
    func apiRequest<A>(_ session: URLSession = URLSession.shared, resource: Resource<A>, failure: @escaping (Reason, Data?) -> (), completion: @escaping (A) -> ()) {
        let urlString = resource.baseURL + "?country=\(resource.countryString)&category=\(resource.categoryString)&sortBy=publishedAt&apiKey=3ce4f4731af54458b4aaec0a58d1f644"
        let url = URL(string: urlString)
        
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = resource.method.rawValue
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            
            if let httpResponse = response as? HTTPURLResponse {
                if (isSuccessStatusCode(httpResponse.statusCode)) {
                    if let responseData = data {
//                        print(String(data: responseData, encoding: .utf8)!)
                        if let result = resource.parse(responseData) {
                            completion(result)
                        }
                        else {
                            failure(Reason.couldNotParseJSON, data)
                        }
                    }
                    else {
                        failure(Reason.noData, data)
                    }
                }
                else {
                    failure(Reason.noSuccessStatusCode(statusCode: httpResponse.statusCode), data)
                }
            }
            else {
                failure(Reason.other(error! as NSError), data)
            }
        }
        task.resume()
    }
}

func isSuccessStatusCode(_ statusCode: Int) -> Bool {
    return (statusCode / 200 == 1)
}
