//
//  NetworkOperation.swift
//  Stormy
//
//  Created by Лидия Хашина on 11.09.15.
//  Copyright (c) 2015 OnlineLab. All rights reserved.
//

import Foundation

class NetworkOperation {
    
    lazy var config: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
    lazy var session: NSURLSession = NSURLSession(configuration: self.config)
    let queryURL: NSURL
    
    typealias JSONDictionaryCompletion = ([String: AnyObject]?) -> Void
    
    init(url: NSURL){
        self.queryURL = url
    }
    
    
    
    func downloadJSONFromURL (completion: JSONDictionaryCompletion) {
        let request: NSURLRequest = NSURLRequest(URL: queryURL)
        let dataTask = session.dataTaskWithRequest(request) {
            (let data, let response, let error) in
            
            // 1. Check HTTP response for successful GET response
            
            if let httpResponse = response as? NSHTTPURLResponse {
                
                switch(httpResponse.statusCode) {
                case 200:
                    // 2. Create JSON object with data
                    let JSONDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? [String: AnyObject]
                    completion(JSONDictionary)
                default:
                    println("GET request not successful. HTTP status code: \(httpResponse.statusCode)")
                }
                
            } else {
                println("Error: Nor a valid HTTP response")
            }
        }
        
        dataTask.resume()
    }
    
}