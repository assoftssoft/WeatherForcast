//
//  City.swift
//  Assessment
//
//  Created by Ahmed Baloch on 6/24/1397 AP.
//  Copyright © 1397 admin. All rights reserved.
//

import Foundation

class City {
    var id = Int()
    var name = String()
    var country = String()
    var coord : Coord?
    
    init(id : Int , name : String , country : String , coord : Coord) {
        self.id = id
        self.name = name
        self.country = country
        self.coord = coord
    }
}
