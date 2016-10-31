//
//  RestApiManager.swift
//  SwiftRestAPI
//
//  Created by Ondrej Andrysek on 22/03/2016.
//  Copyright © 2016 Ondrej Andrysek. All rights reserved.
//

import Foundation

typealias ServiceResponse = (JSON, NSError?) -> Void

class RestApiManager: NSObject {
    static let sharedInstance = RestApiManager()
    
    
    var baseURL = "http://api.openweathermap.org/data/2.5/weather?q=Brno&units=metric&appid=e6ff2b672682c6a1b32cba7c86fbce6c"
    
    //get json data
    func getDataFromURL(onCompletion: (JSON) -> Void){
        makeHTTPGetRequest(baseURL, onCompletion: {json, err -> Void in
        onCompletion(json)
        })
    }
    //make http request
    func makeHTTPGetRequest(path: String, onCompletion: ServiceResponse){
        
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: { (data, responde, error) -> Void in
            if let jsonData = data{
                let json:JSON = JSON(data: jsonData)
                onCompletion(json,error)
            }
                
            else {
                onCompletion(nil,error)
            }
        })
            
        task.resume()
        
    }
    
    func setCity(city_name : String){
        baseURL = "http://api.openweathermap.org/data/2.5/weather?q=\(city_name)&units=metric&appid=e6ff2b672682c6a1b32cba7c86fbce6c"
    }
    
}