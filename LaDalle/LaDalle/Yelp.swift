//
//  Yelp.swift
//  LaDalle
//
//  Created by Loris Mazloum on 9/18/16.
//  Copyright © 2016 Loris Mazloum. All rights reserved.
//

import Foundation
import UIKit



class Yelp {
    private let server = "https://api.yelp.com/v3/"
    
    //static let sharedInstance = Yelp()
    var token: String? = nil
    
    init() {
    }

}


//Get Yelp Token
extension Yelp {
    func getToken() {
        
        print("Calling Yelp to get a token")
        // create the url
        //let link = server + "oauth2/token"
        let link = "https://api.yelp.com/oauth2/token"
        guard let url = URL(string: link) else { return }
        
        //set headers
        let headers = [
            "content-type": "application/x-www-form-urlencoded"
        ]
        
        let clientId = valueForAPIKey(named: "YELP_API_CLIENT_ID")
        let clientSecret = valueForAPIKey(named: "YELP_API_SECRET_ID")
        
        // set body
        let bodyData = "client_id=\(clientId)&client_secret=\(clientSecret)&grant_type=client_credentials"
        
        //set request
        var request = URLRequest.init(url: url)
        
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = bodyData.data(using: .utf8)
        
        
        //create sharedSession
        let sharedSession = URLSession.shared
        
        // setup completion handler
        let completionHandler: (Data?, URLResponse?, Error?) -> Void = { data, response, error in
            
            guard let data = data, error == nil else {
                // check for networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options:
                    JSONSerialization.ReadingOptions.allowFragments)
                
                guard let result = jsonObject as? NSDictionary else { return }
                guard let accessToken = result["access_token"] as? String else { return }
                
                self.token = accessToken
                
                //store token in plist
                
            } catch {
                print("Could not get an Access Token")
                return
            }
            
        }
        
        // set dataTask
        let dataTask = sharedSession.dataTask(with: request, completionHandler: completionHandler)
        
        //resume dataTask
        dataTask.resume()
        
    }
}
