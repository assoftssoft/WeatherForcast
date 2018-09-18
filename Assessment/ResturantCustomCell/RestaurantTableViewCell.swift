//
//  RestaurantTableViewCell.swift
//  Assessment
//
//  Created by admin on 14/09/2018.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import Cosmos
class RestaurantTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var Openimg: UIImageView!
    
    @IBOutlet weak var OpenValue: UILabel!
    
    @IBOutlet weak var RatingValue: CosmosView!
    @IBOutlet weak var resturantImg: UIImageView!
    
    @IBOutlet weak var ResturantName: UILabel!
    
    @IBOutlet weak var ResturantAddress: UILabel!

    @IBOutlet weak var RateValue: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
