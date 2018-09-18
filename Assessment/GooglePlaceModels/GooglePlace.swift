//
//  GooglePlace.swift
//  Assessment
//
//  Created by Ahmed Baloch on 6/25/1397 AP.
//  Copyright © 1397 admin. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation
import SwiftyJSON

class GooglePlace {
    let name: String
    let address: String
    let coordinate: CLLocationCoordinate2D
    let placeType: String
    var photoReference: String?
    var photo: UIImage?
    var rating : Float?
    var isopen : Bool?
    
    init(dictionary: [String: Any], acceptedTypes: [String])
    {
        let json = JSON(dictionary)
        
        name = json["name"].stringValue
        address = json["vicinity"].stringValue
        rating = json["rating"].floatValue
        let open = json["opening_hours"]
        isopen = open["open_now"].boolValue
        let lat = json["geometry"]["location"]["lat"].doubleValue as CLLocationDegrees
        let lng = json["geometry"]["location"]["lng"].doubleValue as CLLocationDegrees
        coordinate = CLLocationCoordinate2DMake(lat, lng)
        
        photoReference = json["photos"][0]["photo_reference"].string
        
        var foundType = "restaurant"
        let possibleTypes = acceptedTypes.count > 0 ? acceptedTypes : ["bakery", "bar", "cafe", "grocery_or_supermarket", "restaurant"]
        
        if let types = json["types"].arrayObject as? [String] {
            for type in types {
                if possibleTypes.contains(type) {
                    foundType = type
                    break
                }
            }
        }
        placeType = foundType
    }
}
