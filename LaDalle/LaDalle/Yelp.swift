//
//  Yelp.swift
//  LaDalle
//
//  Created by Loris Mazloum on 9/18/16.
//  Copyright © 2016 Loris Mazloum. All rights reserved.
//

import Foundation
import UIKit

struct Location {
    let address1: String
    let address2: String
    let address3: String
    let city: String
    let state: String
    let zipCode: String
    let country: String
    
    static func fromDictionary(dictionary: NSDictionary) -> Location? {
        
        //Pull out each individual element from the dictionary
        guard let address1 = dictionary["address1"] as? String,
            let address2 = dictionary["address2"] as? String,
            let address3 = dictionary["address3"] as? String,
            let city = dictionary["city"] as? String,
            let state = dictionary["state"] as? String,
            let zipCode = dictionary["zip_code"] as? String,
            let country = dictionary["country"] as? String
            else {
                return nil
        }
        
        //Take the data parsed and create a Place Object from it
        return Location(address1: address1, address2: address2, address3: address3, city: city, state: state, zipCode: zipCode, country: country)
    }
}

struct Coordinates {
    let latitude: Double
    let longitude: Double
    
    static func fromDictionary(dictionary: NSDictionary) -> Coordinates? {
        
        //Pull out each individual element from the dictionary
        guard let latitude = dictionary["latitude"] as? Double,
            let longitude = dictionary["longitude"] as? Double
            else {
                return nil
        }
        
        //Take the data parsed and create a Place Object from it
        return Coordinates(latitude: latitude, longitude: longitude)
    }
}

class Business {
    let name: String
    let location: Location
    let coordinates: Coordinates
    let rating: Double
    let reviewCount: Int
    let photos: [UIImage]
    
    init(name: String, location: Location, coordinates: Coordinates, rating: Double, reviewCount: Int, photos: [UIImage]) {
        self.name = name
        self.location = location
        self.coordinates = coordinates
        self.rating = rating
        self.reviewCount = reviewCount
        self.photos = photos
        
    }
    
    static func fromDictionary(dictionary: NSDictionary) -> Business? {
        
        //Pull out each individual element from the dictionary
        guard let name = dictionary["name"] as? String,
            let location = dictionary["location"] as? Location,
            let coordinates = dictionary["coordinates"] as? Coordinates,
            let rating = dictionary["rating"] as? Double,
            let reviewCount = dictionary["review_count"] as? Int,
            let photos = dictionary["photos"] as? [UIImage]
            else {
                return nil
        }
        
        //Take the data parsed and create a Place Object from it
        return Business(name: name, location: location, coordinates: coordinates, rating: rating, reviewCount: reviewCount, photos: photos)
    }

}


class Yelp {
    private let server = "https://api.yelp.com/v3/"
    
    static let instance = Yelp()
    var token: String? = nil
    
    private init() {
    }
    
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
        
        // set body
        let bodyData = "client_id=xxxxxxx&client_secret=xxxxxxx&grant_type=client_credentials"
        
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
            
            //let responseString = String(data: data, encoding: .utf8)
            //print("responseString = \(responseString)")
            
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options:
                    JSONSerialization.ReadingOptions.allowFragments)
                
                guard let result = jsonObject as? NSDictionary else { return }
                guard let accessToken = result["access_token"] as? String else { return }
                
                print("Access TOken : >>>>> \(accessToken) ")
                self.token = accessToken
                
            } catch { return }
            
        }
        
        // set dataTask
        let dataTask = sharedSession.dataTask(with: request, completionHandler: completionHandler)
        
        //resume dataTask
        dataTask.resume()
        
    }
    
    func getLocalPlaces(forCategory category: String, coordinates: Coordinates) -> [Business] {
        
        
        guard self.token != nil else { return [] }
        
        let link = "https://api.yelp.com/v3/businesses/search?category_filter=\(category)&latitude=\(coordinates.latitude)&longitude=\(coordinates.longitude)"
        
        //set headers
        let headers = [
            "Authorization": "Bearer \(token)"
        ]
        
        guard let url = URL(string: link) else { return [] }
    
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
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            
//            do {
//                let jsonObject = try JSONSerialization.jsonObject(with: data, options:
//                    JSONSerialization.ReadingOptions.allowFragments)
//                //                let jsonString = String(describing: jsonObject)
//                //                print("RESPONSE JSON: \(jsonString)")
//                
//                guard let result = jsonObject as? NSDictionary else { return }
//                guard let accessToken = result["access_token"] as? String else { return }
//                
//                print("Access TOken : >>>>> \(accessToken) ")
//                self.token = accessToken
//                
//                //                DispatchQueue.main.async {
//                //                    // do something in the main queue
//                //                    //self.dataContentText.text = jsonString
//                //                }
//                
//            } catch { return }
            
        }
        
        // set dataTask
        let dataTask = sharedSession.dataTask(with: request, completionHandler: completionHandler)
        
        //resume dataTask
        dataTask.resume()
        
        return []
        
    }

}
