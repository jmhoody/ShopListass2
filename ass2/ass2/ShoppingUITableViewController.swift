//
//  ShoppingUITableViewController.swift
//  ass2
//
//  Created by Justin Hood on 24/5/18.
//  Copyright © 2018 University of Tasmania. All rights reserved.
//

import UIKit

class ShoppingUITableViewController: UITableViewController {

    var shoppingItems = [ShoppingItem]()
    var inEditMode = false
    var refresher: UIRefreshControl!
    
    @IBOutlet var editButton: UIBarButtonItem!
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let database : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase3")

        shoppingItems = database.selectAllItems()
        

        /*refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresher.addTarget(self, action: #selector(ShoppingUITableViewController.refreshTable), for: UIControlEvents.valueChanged)
        tableView.addSubview(refresher)*/
        
        // display an Edit button in the navigation bar for this view controller
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @IBAction func toggleEditMode(_ sender: Any) {
        inEditMode = !inEditMode
        self.tableView.setEditing(inEditMode, animated: true)
        if (inEditMode) {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(ShoppingUITableViewController.toggleEditMode(_:)))
        } else {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(ShoppingUITableViewController.toggleEditMode(_:)))
        }
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return shoppingItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Shopping2UITableViewCell", for: indexPath)
        let item = shoppingItems[indexPath.row]

        if let itemCell = cell as? Shopping2UITableViewCell
        {
            itemCell.nameLabel.text = item.name
            itemCell.costTotalLabel.text = String(item.costTotal!)
            itemCell.quantityLabel.text = String(item.numberOf)
            itemCell.costLabel.text = String(item.cost!)
            /*if item.purchased = 0 {
                itemCell.purchasedSwitch.setOn(<#T##on: Bool##Bool#>, animated: <#T##Bool#>)
            } else {
                itemCell.purchasedSwitch.
            }
        */
        }
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            shoppingItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        } else if editingStyle == .insert {
            shoppingItems.insert(at: indexPath.row)
            tableView.insertRows(at: [indexPath], with: .automatic)
            // Create a new instance of the appropriate class,
            //insert it into the array, and add a new row to the table view
        }
    }
    
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let temp = shoppingItems.remove(at: fromIndexPath.row)
        shoppingItems.insert(temp, at: to.row)
    }

    @objc func refreshTable(){
        tableView.reloadData()

        refresher.endRefreshing()
    }
}
