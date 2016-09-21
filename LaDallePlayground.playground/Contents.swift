//: Playground - noun: a place where people can play

import UIKit


let link = "https://s3-media2.fl.yelpcdn.com/bphoto/kPSLCUIWOkDYBbId-fSj9w/o.jpg"


func getImage(from url: String) -> UIImage? {
    
    guard let imageUrl = URL(string: url) else { return nil  }
    
    do {
        let imageData = try Data(contentsOf: imageUrl)
        
        guard let image = UIImage(data: imageData) else { return nil }
        return image
    } catch {
        print("Could not create a ")
    }
    
    return nil
}


getImage(from: link)
