//
//  Coordinates.swift
//  LaDalle
//
//  Created by Loris Mazloum on 9/19/16.
//  Copyright © 2016 Loris Mazloum. All rights reserved.
//

import Foundation

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
        
        //Take the data parsed and create a Coordinate Object from it
        return Coordinates(latitude: latitude, longitude: longitude)
    }
}
