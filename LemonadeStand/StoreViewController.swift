//
//  StoreViewController.swift
//  LemonadeStand
//
//  Created by Jason Leibowitz on 12/20/14.
//  Copyright (c) 2014 Jason Leibowitz. All rights reserved.
//

import UIKit

protocol DataEnteredDelegate {
    func userDidEnterInformation(lemonsInInventory:Int, iceInInventory:Int, walletBalance:Int)
}

class StoreViewController: UIViewController {

    @IBOutlet weak var walletBalanceLabel: UILabel!
    @IBOutlet weak var lemonsInInventoryLabel: UILabel!
    @IBOutlet weak var iceInInventoryLabel: UILabel!
    
    var delegate:DataEnteredDelegate? = nil
    
    var lemonsInInventory = 0
    var iceInInventory = 0
    var walletBalance = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lemonsInInventoryLabel.text = "\(lemonsInInventory)"
        iceInInventoryLabel.text = "\(iceInInventory)"
        walletBalanceLabel.text = "\(walletBalance)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func purchaseLemonButtonPressed(sender: UIButton) {
        if walletBalance >= 2 {
            lemonsInInventory += 1
            walletBalance -= 2
            updateLabels()
        } else {
            showAlertWithText(header: "Not Enough Money", message: "You don't have enough money to purchase any more lemons. Do you think lemons grow on trees?")
        }
    }
    
    @IBAction func returnLemonButtonPressed(sender: UIButton) {
        if lemonsInInventory >= 1 {
            lemonsInInventory -= 1
            walletBalance += 2
            updateLabels()
        } else {
            showAlertWithText(header: "No Lemons", message: "You don't have any lemons to return.")
        }
    }
    
    @IBAction func purchaseIceButtonPressed(sender: UIButton) {
        if walletBalance >= 1 {
            iceInInventory += 1
            walletBalance -= 1
            updateLabels()
        } else {
            showAlertWithText(header: "Not Enough Money", message: "You don't have enough money to purchase any more ice. Do you think it comes from water or something?")
        }
    }
    
    @IBAction func returnIceButtonPressed(sender: UIButton) {
        if iceInInventory >= 1 {
            iceInInventory -= 1
            walletBalance += 1
            updateLabels()
        } else {
            showAlertWithText(header: "No Ice", message: "You don't have any ice to return. Did you forget to leave the AC on?")
        }
    }
    
    @IBAction func checkOutButtonPressed(sender: AnyObject) {
        if (delegate != nil) {
            let checkoutLemonsInInventory:Int = lemonsInInventory
            let checkoutIceInInventory:Int = iceInInventory
            let checkoutWalletBalance:Int = walletBalance
            delegate!.userDidEnterInformation(checkoutLemonsInInventory, iceInInventory: checkoutIceInInventory, walletBalance: checkoutWalletBalance)
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    func updateLabels() {
        walletBalanceLabel.text = "\(walletBalance)"
        lemonsInInventoryLabel.text = "\(lemonsInInventory)"
        iceInInventoryLabel.text = "\(iceInInventory)"
    }
    
    func showAlertWithText(header: String = "Warning", message: String) {
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
