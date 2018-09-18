//
//  WeatherDailyCastView.swift
//  Assessment
//
//  Created by admin on 12/09/2018.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class WeatherDailyCastView: UICollectionViewCell {

    @IBOutlet weak var weatherDay: UILabel!
    
    @IBOutlet weak var weatherDailyCastImg: UIImageView!
    
    @IBOutlet weak var weatherDailyCastValue: UILabel!
    
    @IBOutlet weak var weatherTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
