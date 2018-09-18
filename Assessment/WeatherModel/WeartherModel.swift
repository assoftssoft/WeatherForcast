//
//  WeartherModel.swift
//  Assessment
//
//  Created by Ahmed Baloch on 6/24/1397 AP.
//  Copyright © 1397 admin. All rights reserved.
//

import Foundation
class WeatherModel {
    
    var cod = Int()
    var message = Float()
    var cnt = Int()
    var list = [List]()
    var city : City?
    init(cod : Int , message : Float , cnt : Int , list : [List] , city : City) {
        self.cod = cod
        self.message = message
        self.cnt = cnt
        self.list = list
        self.city = city
        
    }
}
