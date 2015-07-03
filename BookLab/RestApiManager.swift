//
//  RestApiManager.swift
//  BookLab
//
//  Created by Pedro Russo on 01/07/15.
//  Copyright (c) 2015 Pedro Russo. All rights reserved.
//

import Foundation

typealias ServiceResponse = (JSON, NSError?) -> Void

class RestApiManager: NSObject {
    static let sharedInstance = RestApiManager()
    
    let baseURL = "http://interview.locationlabs.com"
    
    func getAllBooks(onCompletion: (JSON) -> Void) {
        let route = baseURL+"/book"
        makeHTTPGetRequest(route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func updateBook(package: JSON, onCompletion: (JSON) -> Void){
        let route = baseURL + package["uri"].string!
        
        var body:JSON = [:]
        body["read"].boolValue = package["read"].boolValue
        
        makeHTTPPutRequest(route, body: body.dictionaryObject!, onCompletion: { json, err in
            if json != nil{
                onCompletion(json as JSON)
            } else {
                println(err)
            }
            
        })
    }
    
    func deleteBook(package: JSON, onCompletion: (NSURLResponse)-> Void) {
        let route = baseURL + package["uri"].string!
        
        makeHTTPDeleteRequest(route, onCompletion: {
            response in onCompletion(response as NSURLResponse)
            })
    }
    
    func addBook(package: JSON, onCompletion: (JSON, NSURLResponse) -> Void){
        let route = baseURL+"/book"
        makeHTTPPostRequest(route, body: package.dictionaryObject!, onCompletion: {
            json, response in onCompletion(json, response)
        })
    }
    
    func makeHTTPPostRequest(path: String, body: [String: AnyObject], onCompletion: (JSON, NSURLResponse) -> Void) {
        var err: NSError?
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(body, options: nil, error: &err)
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            let response = response
            let json:JSON = JSON(data: data)
            onCompletion(json as JSON, response as NSURLResponse)
        })
        task.resume()
    }
    
    func makeHTTPPutRequest(path: String, body: [String: AnyObject], onCompletion: ServiceResponse) {
        var err: NSError?
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        
        // Set the method to PUT
        request.HTTPMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Set the PUT body for the request
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(body, options: nil, error: &err)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            let json:JSON = JSON(data: data)
            onCompletion(json, err)
        })
        task.resume()
    }
    
    
    func makeHTTPDeleteRequest(path: String, onCompletion: (NSURLResponse) -> Void) {
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        request.HTTPMethod = "DELETE"
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            let response = response
            onCompletion(response as NSURLResponse)
        })
        task.resume()
    }
    
    
    func makeHTTPGetRequest(path: String, onCompletion: ServiceResponse) {
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            let json:JSON = JSON(data: data)
            onCompletion(json, error)
        })
        task.resume()
    }
    
   
    
    
}
