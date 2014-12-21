//
//  ViewController.swift
//  LemonadeStand
//
//  Created by Jason Leibowitz on 12/20/14.
//  Copyright (c) 2014 Jason Leibowitz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Home Controller
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var walletBalanceLabel: UILabel!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    @IBOutlet weak var numberOfLemonsInLemonadeLabel: UILabel!
    @IBOutlet weak var numberOfIceCubesInLemonadeLabel: UILabel!
    @IBOutlet weak var numberOfLemonsInInventoryLabel: UILabel!
    @IBOutlet weak var numberofIceCubesInInventoryLabel: UILabel!
    
    var currentGame = LemonadeStand()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        walletBalanceLabel.text = "\(currentGame.walletBalance)"
        numberOfLemonsInInventoryLabel.text = "\(currentGame.lemonsInInventory)"
        numberofIceCubesInInventoryLabel.text = "\(currentGame.iceInInventory)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Main Page Actions
    @IBAction func goToStoreButtonPressed(sender: UIButton) {
    }
    @IBAction func startDayButtonPressed(sender: UIButton) {
    }
    @IBAction func addLemonToLemonadeButtonPressed(sender: UIButton) {
        if currentGame.lemonsInInventory >= 1 {
            currentGame.increaseLemonsInLemonade()
            updateLabels()
        } else {
            showAlertWithText(header: "No More Lemons", message: "You have no lemons in your inventory. If you want to add more to the lemonade you have to purchase more in the store.")
        }
    }
    @IBAction func removeLemonFromLemonadeButtonPressed(sender: UIButton) {
        if currentGame.lemonsInLemonade >= 1 {
            currentGame.decreaseLemonsInLemonade()
            updateLabels()
        } else {
            showAlertWithText(header: "No Lemons", message: "You can't remove lemons from a lemonade that doesn't have any lemons. Why don't you add some.")
        }
    }
    @IBAction func addIceCubeToLemonadeButtonPressed(sender: UIButton) {
        if currentGame.iceInInventory >= 1 {
            currentGame.increaseIceInLemonade()
            updateLabels()
        } else {
            showAlertWithText(header: "Ice Is Nice", message: "Too bad you don't have any to add to the lemonade. Buy some more in the store.")
        }
    }
    @IBAction func removeIceCubeFromLemonadeButtonPressed(sender: UIButton) {
        if currentGame.iceInLemonade >= 1 {
            currentGame.decreaseIceInLemonade()
            updateLabels()
        } else {
            showAlertWithText(header: "Iceless Lemonade", message: "There isn't any ice in the lemonade. You should probably add some.")
        }
    }
    
    func showAlertWithText(header: String = "Warning", message: String) {
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func updateLabels() {
        numberOfLemonsInLemonadeLabel.text = "\(currentGame.lemonsInLemonade)"
        numberOfIceCubesInLemonadeLabel.text = "\(currentGame.iceInLemonade)"
        numberOfLemonsInInventoryLabel.text = "\(currentGame.lemonsInInventory)"
        numberofIceCubesInInventoryLabel.text = "\(currentGame.iceInInventory)"
        walletBalanceLabel.text = "\(currentGame.walletBalance)"
    }

}

