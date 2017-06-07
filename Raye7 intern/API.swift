//
//  API.swift
//  Raye7 intern
//
//  Created by Mohamed El Naggar on 6/8/17.
//  Copyright © 2017 Mohamed El Naggar. All rights reserved.
//

import Foundation
import Alamofire

class API {
    
    class func getData(id: Int , completion: @escaping (_ success: Bool ,_ data: [(String , String)]?) -> Void) {
        // Take a userID and Return all of his Posts
        // I can get data of All userIDs but it’s 100 so time will be huge ,
        // thus i used userID to Download 10 only every Time
        // INFO --> completion --> data can be nil
        
        // Server URL as ( String )
        let url = "https://jsonplaceholder.typicode.com/posts"
        
        let parameters = [
            "userId": id,
            ]
        
        // Request to Server
        // METHOD --> GET
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default , headers: nil)
            
            
            // Recieve JSON Response
            .responseJSON { (result) in
                // if Fail to get JSON
                guard result.result.isSuccess else {
                    print("Can’t get results from server , try again xD")
                    completion(false , nil)
                    return
                }
                
                // Guard result.result.value if i can casting it as [[String: Any]]
                guard let responseJSON = result.result.value as? [[String: Any]] else {
                    print("Error")
                    completion(false , nil)
                    return
                }
                
                // result will send through Compeltion
                var returnedData = [(String , String)]()
                
                //print(responseJSON)
                
                // iterate over all responses Array
                for i in 0..<responseJSON.count {
                    // get Title and Body from responseJSON
                    guard let title = responseJSON[0]["title"] as? String , let body = responseJSON[i]["body"] as? String else { continue }
                    
                    // secure data
                    returnedData.append((title , body))
                }
                
                // successful get Data From server
                completion(true , returnedData)
        }
    }
    
}
