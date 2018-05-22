//
//  ItemTableViewCell.swift
//  Assignment2
//
//  Created by Justin Hood on 22/5/18.
//  Copyright © 2018 University of Tasmania. All rights reserved.
//

import Foundation
import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet var itemName: UILabel!
    @IBOutlet var itemCost: UILabel!
    @IBOutlet var itemNu: UILabel!
    @IBOutlet var itemCostSum: UILabel!
    @IBOutlet var itemPurchase: UISwitch!

    func fillCellOutlets(_ p: Product) {
        self.itemName.text = p.name
        self.itemCost.text = String(format: "$%.2f", Float(p.cost) / 100.0)
        self.itemNu.text = String(format: "$%.2f", Float(p.defaultQuantity) / 100.0)
        self.itemCostSum.text = String(format: "$%.2f", Float(p.costSum) / 100.0)
        //self.itemPurchase = Bool(p.purchase)
    }
}
