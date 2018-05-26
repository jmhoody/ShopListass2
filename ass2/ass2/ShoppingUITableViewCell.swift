//
//  ShoppingUITableViewCell.swift
//  ass2
//
//  Created by Justin Hood on 25/5/18.
//  Copyright © 2018 University of Tasmania. All rights reserved.
//

import UIKit

class ShoppingUITableViewCell: UITableViewCell {

    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
