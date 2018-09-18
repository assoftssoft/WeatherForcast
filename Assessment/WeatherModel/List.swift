//
//  List.swift
//  Assessment
//
//  Created by Ahmed Baloch on 6/24/1397 AP.
//  Copyright © 1397 admin. All rights reserved.
//

import Foundation

class List {
    var dt = Int()
    var dt_txt = String()
    var main : Main?
    var weather = [Weather]()
    var clouds : Cloud?
    var wind : Wind?
    var rain : Rain?
    var sys : Sys?
    
    init(dt : Int,dt_txt : String , main : Main , weather : [Weather], clouds : Cloud , wind : Wind , rain : Rain , sys : Sys ) {
        self.dt = dt
        self.dt_txt = dt_txt
        self.main = main
        self.weather = weather
        self.clouds = clouds
        self.wind = wind
        self.rain = rain
        self.sys = sys
        
    }
}
