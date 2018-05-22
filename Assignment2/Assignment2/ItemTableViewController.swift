//
//  ItemTableViewController.swift
//  Assignment2
//
//  Created by Justin Hood on 22/5/18.
//  Copyright © 2018 University of Tasmania. All rights reserved.
//

import Foundation

import UIKit

class ItemTableViewController: UITableViewController, UINavigationControllerDelegate {
    
    var products: [Product] = []
    var inEditMode = false

    override func viewDidLoad() {
        super.viewDidLoad()

        products.append(Product(name:"Butter", defaultQuantity=1, cost=236, purchase=false))

}
