//
//  ViewController.swift
//  Assignment2
//
//  Created by Justin Hood on 11/5/18.
//  Copyright © 2018 University of Tasmania. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var listNameTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 /*
    @IBAction func DisplayAlertAddList(_ sender: Any) {
        let alertController = UIAlertController(title: "Submit a name for the new list",
                                                message: nil,
                                                preferredStyle: .alert)
        alertController.addTextField(configurationHandler: listNameTextField)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: self.okHandler)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        //self.present()

    }
    */
    /*
    func listNameTextField(textField: UIAlertField!){
        listNameTextField = textField
        listNameTextField?.placeholder = "list name"
    }
    
    func okHandler(alert: UIAlertAction!){
        let simpleVC = SimpleVC()
        
    }
    */
}

