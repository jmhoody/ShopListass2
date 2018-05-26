//
//  SendingUIViewController.swift
//  ass2
//
//  Created by Justin Hood on 26/5/18.
//  Copyright © 2018 University of Tasmania. All rights reserved.
//

import UIKit
import MessageUI

class SendingUIViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var emailReciptient: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func SendEmail(_ sender: Any) {
        let sendingEmail = configureMailController()
        if MFMailComposeViewController.canSendMail(){
            self.present(sendingEmail, animated: true, completion: nil)
        }else{
            testMail()
        }
    }
    
    func configureMailController() -> MFMailComposeViewController
    {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients([String]?)
        mailComposerVC.setSubject("Incoming Data")
        mailComposerVC.setMessageBody("The is no data to read for you here.", isHTML: false)
        
        return mailComposerVC
    }
    
    func testMail(){
        let sendMailError = UIAlertController(title: "Failed to send email", message: "You device was unabl to send the email", preferredStyle: .alert)
        let dismiss = UIAlertAction(title:"Ok", style: .default, handler: nil)
        sendMailError.addAction(dismiss)
        self.present(sendMailError,animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
