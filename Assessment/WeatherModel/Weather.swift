//
//  Weather.swift
//  Assessment
//
//  Created by Ahmed Baloch on 6/24/1397 AP.
//  Copyright © 1397 admin. All rights reserved.
//

import Foundation
class Weather {
    var id = Int()
    var main = String()
    var description = String()
    var icon = String()
    
    init(id : Int , main : String , description : String, icon : String) {
        self.id = id
        self.main = main
        self.description = description
        self.icon = icon
        
    }
}
