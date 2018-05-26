//
//  ViewController.swift
//  ass2
//
//  Created by Justin Hood on 24/5/18.
//  Copyright © 2018 University of Tasmania. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var database : SQLiteDatabase = SQLiteDatabase(databaseName:"MyDatabase")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(" -----I GOT HERE ------- \n")
        // Do any additional setup after loading the view, typically from a nib.
        //database.createShoppingTable()
        //print(database.selectAllItems())

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

