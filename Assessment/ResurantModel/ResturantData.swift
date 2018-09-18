//
//  ResturantData.swift
//  Assessment
//
//  Created by Ahmed Baloch on 6/25/1397 AP.
//  Copyright © 1397 admin. All rights reserved.
//

import Foundation
import GoogleMaps
import UIKit

class ResturantData {
    var address = String()
    var coordinate = CLLocationCoordinate2D()
    var name = String()
    var refrences = String()
    var placeType = String()
    var rating = Float()
    var isopen = Bool()
    
    init(isopen : Bool, address : String , coordinate : CLLocationCoordinate2D , name : String   ,  placeType : String , rating : Float,refrences : String ) {
        
        self.address = address
        self.coordinate = coordinate
        self.name = name
       self.refrences = refrences
         self.placeType = placeType
        self.rating = rating
        self.isopen = isopen
    }
}
