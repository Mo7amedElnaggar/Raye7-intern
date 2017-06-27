//
//  API.swift
//  Raye7 intern
//
//  Created by Mohamed El Naggar on 6/8/17.
//  Copyright © 2017 Mohamed El Naggar. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class API {
    
    class func getData(id: Int , completion: @escaping (_ success: Bool ,_ data: [(String , String)]?) -> Void) {
        // Take a userID and Return all Posts of him
        // I can get data of All userIDs but it’s 100 so time will be huge ( if Image or bigSize data ) ,
        
        // thus i used userID to Download 10 only every Time
        
        // INFO --> completion --> data can be nil
        
        // Server URL as ( String )
        let urlString = "https://jsonplaceholder.typicode.com/posts"
        
        let parameters = [
            "userId": id,
            ]
        
        // Request to Server
        // METHOD --> GET
        Alamofire.request(urlString, method: .get, parameters: parameters, encoding: URLEncoding.default , headers: nil)
            
            // Recieve JSON Response
            .responseJSON { (response) in
                
                switch(response.result) {
                case .failure( _): // Failed to get DATA ( error )
                    completion(false , nil)
                    
                case .success(let val ): // DONE
                    
                    // result will send through Compeltion
                    
                    // definitely done ,
                    completion(true , getDataFromJsonPosts(val: val))
                }
        }
    }
    
    // func iterate over all userID’s Posts and return Only array of titles , bodies
    class func getDataFromJsonPosts(val: Any) -> [(String , String)]? {
        
        // convert Any to JSON Format
        let jsonPosts = JSON(val)
        
        // Array of pairs ( titlt as String , body as String )
        var data = [(String , String)]() // Empty Array
        
        // iterate over all The Posts
        for indx in 0 ..< jsonPosts.count {
            let post = jsonPosts.array![indx]
            if let title = post["title"].string , let body = post["body"].string {
                // Add Post Title , Post body to Array
                data.append((title , body))
            }
        }
        
        return data // DONE
    }
    
}
