//
//  Business.swift
//  LaDalle
//
//  Created by Loris Mazloum on 9/19/16.
//  Copyright © 2016 Loris Mazloum. All rights reserved.
//

import Foundation

class Business {
    let name: String
    let id: String
    let location: Location
    let coordinates: Coordinates
    let rating: Double
    let reviewCount: Int
    //let photos: [String]
    
    init(name: String, id: String, location: Location, coordinates: Coordinates, rating: Double, reviewCount: Int) {
        self.name = name
        self.id = id
        self.location = location
        self.coordinates = coordinates
        self.rating = rating
        self.reviewCount = reviewCount
    }
    
    static func fromDictionary(dictionary: NSDictionary) -> Business? {
        
        //Pull out each individual element from the dictionary
        guard let name = dictionary["name"] as? String,
            let id = dictionary["id"] as? String,
            let rating = dictionary["rating"] as? Double,
            let reviewCount = dictionary["review_count"] as? Int
            else {
                print("Error creating object from dictionary")
                return nil
        }
        
        // create photo array
        // guard let photos = dictionary["photos"] as? [String] else { return nil }
        
        
        //create location
        guard let locationDictionary = dictionary["location"] as? NSDictionary else { return nil }
        guard let locationObject = Location.fromDictionary(dictionary: locationDictionary) else {return nil}
        
        //create coordinates
        guard let coordinatesDictionary = dictionary["coordinates"] as? NSDictionary else { return nil }
        guard let coordinatesObject = Coordinates.fromDictionary(dictionary: coordinatesDictionary) else { return nil}
        
        
        //Take the data parsed and create a Place Object from it
        return Business(name: name, id: id, location: locationObject, coordinates: coordinatesObject, rating: rating, reviewCount: reviewCount)
    }
    
}
