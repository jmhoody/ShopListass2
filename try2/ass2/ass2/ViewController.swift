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
        // Do any additional setup after loading the view, typically from a nib.
        database.insert(item:ShoppingItem(ID: 0, name:"Lord of the Rings", year:2003, director:"Peter Jackson"))
        database.insert(item:ShoppingItem(ID: 1, name:"The Matrix", year:1999, director:"Lana Wachowski, Lilly Wachowski"))
        
        print(database.selectAllItems())
        
        database.update(item:ShoppingItem(ID:0, name:"Lord of the Rings: Return of the King", year:2003, director:"Peter Jackson"))
        print(database.selectItemBy(id:0) ?? "Movie not found")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

