//
//  ApiRequest.swift
//  Assessment
//
//  Created by Ahmed Baloch on 6/24/1397 AP.
//  Copyright © 1397 admin. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ApiRequest {
    var link = "https://api.openweathermap.org/data/2.5/forecast?"
     var AppID = "b842ba05839bca7de1624bbe278a334c"
    func Get_Weather_Results(lat: Float , lon : Float, completionHandler: @escaping (Bool, JSON?,String) -> ()) {
        let parameters = ["APPID" : AppID , "lat": lat ,"lon":lon ] as [String : Any]
        Alamofire.request(link, method: .get, parameters: parameters, encoding: URLEncoding.queryString).responseJSON { (response) in
            
            switch response.result
            {
            case .success(_):
               
                let swiftyJsonVar = JSON(response.result.value!)
                completionHandler(true, JSON(swiftyJsonVar),"Response Get")
                
                break
            case .failure(let error):
                completionHandler(true, JSON(error),"Response Get")
                break
            }
        }
    }
    
    func dateconverttoday(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let datem = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "EEEE"///this is what you want to convert format
        
        let day = dateFormatter.string(from: datem!)
        print(day)
        return day
    }
    
    func dateconvertdatetime(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let datem = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "MMM d, h:mm a"///this is what you want to convert format
        
        let day = dateFormatter.string(from: datem!)
        print(day)
        return day
    }
    
}
