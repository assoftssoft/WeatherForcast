//
//  Main.swift
//  Assessment
//
//  Created by Ahmed Baloch on 6/24/1397 AP.
//  Copyright © 1397 admin. All rights reserved.
//

import Foundation

class Main {
    var temp = Float()
    var temp_min = Float()
    var temp_max = Float()
    var pressure = Float()
    var sea_level = Float()
    var grnd_level = Float()
    var humidity = Float()
    var temp_kf = Float()
    
    init(temp : Float , temp_min : Float , temp_max : Float , pressure : Float , sea_level : Float , grnd_level : Float , humidity : Float , temp_kf: Float) {
        self.temp = temp
        self.temp_min = temp_min
        self.temp_max = temp_max
        self.pressure = pressure
        self.sea_level = sea_level
        self.grnd_level = grnd_level
        self.humidity = humidity
        self.temp_kf = temp_kf
        
    }
}
