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

// Get Local Places
extension Yelp {
    
    class func getLocalPlaces(forCategory category: String, coordinates: Coordinates, completionHandler: @escaping ([Business]) -> ()) {
        
        let dataManager = DataManager.sharedInstance

        var arrayOfBusinesses: [Business] = []
        
        let accessToken = valueForAPIKey(named: "YELP_API_ACCESS_TOKEN")
        
        //if radius return 0 results then increase the radius
        let radius = 2011
        
        // limit distance and limit to open only.
        let link = "https://api.yelp.com/v3/businesses/search?categories=\(category)&latitude=\(coordinates.latitude)&longitude=\(coordinates.longitude)&radius=\(radius)" //&open_now=true
        
        //set headers
        let headers = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        guard let url = URL(string: link) else { return }
        
        //set request
        var request = URLRequest.init(url: url)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        //        request.httpBody = bodyData.data(using: .utf8)
        
        
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
            
            //let responseString = String(data: data, encoding: .utf8)
            //print("responseString = \(responseString)")
            
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options:
                    JSONSerialization.ReadingOptions.allowFragments)
                
                guard let result = jsonObject as? NSDictionary else { print("result is not a dictionary"); return }
                guard let total = result["total"] as? Int else { print("no total available"); return }
                guard total > 0 else { print("Search returned 0 results") ; return }
                guard let businesses = result["businesses"] as? NSArray else { print("business is not an array"); return }
                
                for businessObject in businesses {
                    guard let businessDictionary = businessObject as? NSDictionary else { print("businessDict is not a dictionary"); return }
                    
                    // create business object
                    guard let business = Business.fromDictionary(dictionary: businessDictionary) else { print("can't create a business out of the data"); return }
                    //print("> \(business.id) | Business: \(business.name), \(business.reviewCount) reviews with a rating of \(business.rating). Coordinates: \(business.coordinates.latitude) x \(business.coordinates.longitude)" )
                    print("\(business.id)" )
                    
                    // update data manager
                    arrayOfBusinesses.append(business)
                    completionHandler(arrayOfBusinesses)
                    
//                    print("business count before append: \(dataManager.businesses.count)")
//                    dataManager.businesses.append(business)
//                    print("business count after append: \(dataManager.businesses.count)")
                    
                }
                
                
//                                DispatchQueue.main.async {
//                                    // do something in the main queue
//                                    //self.dataContentText.text = jsonString
//                                }
                
            } catch {
                print("Could not get places")
                return
            }
            
            dataManager.businesses = arrayOfBusinesses
            
        }
        
        // set dataTask
        let dataTask = sharedSession.dataTask(with: request, completionHandler: completionHandler)
        
        //resume dataTask
        dataTask.resume()
        
        return
        
    }
}
