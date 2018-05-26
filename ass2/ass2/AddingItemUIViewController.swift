//
//  AddingItemUIViewController.swift
//  ass2
//
//  Created by Justin Hood on 26/5/18.
//  Copyright © 2018 University of Tasmania. All rights reserved.
//

import UIKit

class AddingItemUIViewController: UIViewController {

    @IBOutlet var nameField: UITextField!
    @IBOutlet var quantityField: UITextField!
    @IBOutlet var costField: UITextField!
    @IBAction func submitItemButton(_ sender: UIButton!){
        let alert = UIAlertController(
            title: "",
            message: "",
            preferredStyle: UIAlertControllerStyle.alert)
        
        if (nameField.text == "" || quantityField.text == ""){
            alert.title = "Missing Fields"
            alert.message = "The name and quantity of the item must be included."
        } else {
            let quantityNumberConv :Int32? = Int32(quantityField.text!)
            let costNumberConv :Double? = Double(costField.text!)

            let database : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase3")
            
            if (costNumberConv == nil)
            {
                database.insert(item:ShoppingItem(
                    name:nameField.text!, numberOf: quantityNumberConv!, cost: nil, costTotal: nil, purchased: 0
                ))
            }
            else
            {
            database.insert(item:ShoppingItem(
                name:nameField.text!, numberOf: quantityNumberConv!, cost: costNumberConv!, costTotal: nil, purchased: 0
                ))
            }
            alert.title = "Adding Item"
            alert.message = nameField.text! + "has been added."
            //self.tableView.reloadData()
        }
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
