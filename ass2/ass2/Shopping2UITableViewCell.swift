//
//  Shopping2UITableViewCell.swift
//  ass2
//
//  Created by Justin Hood on 25/5/18.
//  Copyright © 2018 University of Tasmania. All rights reserved.
//

import UIKit

class Shopping2UITableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var costTotalLabel: UILabel!
    @IBOutlet var purchasedSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
