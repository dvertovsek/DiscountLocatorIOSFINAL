//
//  StoreTableViewCell.swift
//  Discount Locator
//
//  Created by MTLab on 28/11/15.
//  Copyright © 2015 air. All rights reserved.
//

import UIKit

class StoreTableViewCell: UITableViewCell {

    @IBOutlet weak var storeImageView: UIImageView!
 
    @IBOutlet weak var storeTitle: UILabel!
    
       @IBOutlet weak var storeDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
