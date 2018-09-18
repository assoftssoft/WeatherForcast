//
//  WeatherMainViewColV.swift
//  Assessment
//
//  Created by admin on 12/09/2018.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class WeatherMainViewColV: UICollectionViewCell {
    
  
  
    
   
    
    
    @IBOutlet weak var countryName: UILabel!
    
    @IBOutlet weak var dayName: UILabel!
    
    @IBOutlet weak var weatherStatus: UILabel!
    
    
    @IBOutlet weak var weatherImg: UIImageView!
    
    @IBOutlet weak var weatherMeter: UILabel!
    
    
    @IBOutlet weak var precipitationValue: UILabel!
    
    @IBOutlet weak var humidityValue: UILabel!
    
    @IBOutlet weak var windValue: UILabel!
    
    @IBOutlet weak var popularRestaurantsBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    
    }
    
   
    public func configure() {
        
    }
    
    @objc func test(){
        print("Ali")
    }
}
