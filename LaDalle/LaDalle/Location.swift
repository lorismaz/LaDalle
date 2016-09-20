//
//  Location.swift
//  LaDalle
//
//  Created by Loris Mazloum on 9/19/16.
//  Copyright © 2016 Loris Mazloum. All rights reserved.
//

import Foundation

struct Location {
    let address1: String
    let address2: String
    let address3: String
    let city: String
    let state: String
    let zipCode: String
    let country: String
    
}

extension Location {
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
        
        //Take the data parsed and create a Location Object from it
        return Location(address1: address1, address2: address2, address3: address3, city: city, state: state, zipCode: zipCode, country: country)
    }
}
