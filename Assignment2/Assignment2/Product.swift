//
//  Product.swift
//  Assignment2
//
//  Created by Justin Hood on 22/5/18.
//  Copyright © 2018 University of Tasmania. All rights reserved.
//

import Foundation

struct Product {
    
    var name: String = ""
    var defaultQuantity: Int = 1
    var cost: Int = 0
    var costSum: Int = 0
    var purchase: Bool = false
    
    var tag: String = ""
    var store: String = ""
    var commonality: String = ""
    
    init (name: String, defaultQuantity: Int = 1, cost: Int = 0, costSum: Int = 0, purchase: Bool = false, tag: String, store: String, commonality: String)
    {
        self.name = name
        self.defaultQuantity = defaultQuantity
        self.cost = cost
        self.costSum = cost*defaultQuantity
        self.purchase = purchase
        
        self.tag = tag
        self.store = store
        self.commonality = commonality
    }
}
