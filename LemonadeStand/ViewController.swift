//
//  ViewController.swift
//  LemonadeStand
//
//  Created by Jason Leibowitz on 12/20/14.
//  Copyright (c) 2014 Jason Leibowitz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, DataEnteredDelegate {

    // Home Controller
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var walletBalanceLabel: UILabel!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    @IBOutlet weak var numberOfLemonsInLemonadeLabel: UILabel!
    @IBOutlet weak var numberOfIceCubesInLemonadeLabel: UILabel!
    @IBOutlet weak var numberOfLemonsInInventoryLabel: UILabel!
    @IBOutlet weak var numberofIceCubesInInventoryLabel: UILabel!
    @IBOutlet weak var yesterdayWeatherLabel: UILabel!
    @IBOutlet weak var yesterdayWeatherImage: UIImageView!
    @IBOutlet weak var lemonadeTasteDescriptionLabel: UILabel!
    
    var currentGame = LemonadeStand()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        walletBalanceLabel.text = "\(currentGame.walletBalance)"
        numberOfLemonsInInventoryLabel.text = "\(currentGame.lemonsInInventory)"
        numberofIceCubesInInventoryLabel.text = "\(currentGame.iceInInventory)"
        updateLabels()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toStore" {
            let svc = segue.destinationViewController as StoreViewController
            svc.lemonsInInventory = currentGame.lemonsInInventory
            svc.iceInInventory = currentGame.iceInInventory
            svc.walletBalance = currentGame.walletBalance
            svc.delegate = self
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Delegate Function
    
    func userDidEnterInformation(lemonsInInventory: Int, iceInInventory: Int, walletBalance: Int) {
        currentGame.lemonsInInventory = lemonsInInventory
        currentGame.iceInInventory = iceInInventory
        currentGame.walletBalance = walletBalance
        updateLabels()
    }
    
    // Main Page Actions
    @IBAction func goToStoreButtonPressed(sender: UIButton) {
    }
    
    @IBAction func startDayButtonPressed(sender: UIButton) {
        if (currentGame.lemonsInLemonade == 0 && currentGame.iceInLemonade > 0) {
            showAlertWithText(header: "Hold On There Cowboy", message: "Are You Trying to sell water? Add some lemons before you try to open for the day.")
        } else if (currentGame.lemonsInLemonade > 0 && currentGame.iceInLemonade == 0) {
            showAlertWithText(header: "When Life Gives You Lemons", message: "Apparently you try to sell pure lemon juice to people. Add some ice to make lemonade.")
        } else if (currentGame.lemonsInLemonade == 0 && currentGame.iceInLemonade == 0) {
            showAlertWithText(header: "Famous Snake Oil", message: "Unless you want to get run out of town add some ingredients so you're not trying to sell nothing.")
        } else {
            var (profits, customers, weather) = currentGame.calculateDailyProfits()
            updateLabels()
            if (currentGame.walletBalance < 3 && currentGame.lemonsInInventory == 0 && currentGame.iceInLemonade == 0) {
                showAlertWithGameOverButton(header: "Game Over", message: "Unfortunately you don't have enough money to buy anything else. You made it to \(currentGame.day) days.")
                println("Game over")
            } else {
                var weatherString:String = ""
                var weatherCustomers:String
                var weatherVerb:String
                switch weather {
                case 0:
                    weatherString = "cold"
                    weatherCustomers = "3"
                    weatherVerb = "less"
                    yesterdayWeatherImage.image = UIImage(named: "Cold")
                    yesterdayWeatherLabel.hidden = false
                    yesterdayWeatherLabel.text = "Cold"
                case 1:
                    weatherString = "mild"
                    weatherCustomers = "no"
                    weatherVerb = "additional"
                    yesterdayWeatherImage.image = UIImage(named: "Mild")
                    yesterdayWeatherLabel.hidden = false
                    yesterdayWeatherLabel.text = "Mild"
                case 2:
                    weatherString = "beautifully warm"
                    weatherCustomers = "3"
                    weatherVerb = "extra"
                    yesterdayWeatherImage.image = UIImage(named: "Warm")
                    yesterdayWeatherLabel.hidden = false
                    yesterdayWeatherLabel.text = "Warm"
                default:
                    weatherString = "fair"
                    weatherCustomers = "no"
                    weatherVerb = "additional"
                    yesterdayWeatherImage.image = UIImage(named: "Mild")
                    yesterdayWeatherLabel.hidden = false
                    yesterdayWeatherLabel.text = "Mild"
                }
                showAlertWithText(header: "Sales Report", message: "\(customers) customers visited you today and you made \(profits) sales earning a profit of $\(profits). The weather today was \(weatherString) so you had \(weatherCustomers) \(weatherVerb) customers.")
            }
        }
    }
    @IBAction func addLemonToLemonadeButtonPressed(sender: UIButton) {
        if currentGame.lemonsInInventory >= 1 {
            currentGame.increaseLemonsInLemonade()
            updateLabels()
            calculateLemonadeFlavor()
        } else {
            showAlertWithText(header: "No More Lemons", message: "You have no lemons in your inventory. If you want to add more to the lemonade you have to purchase more in the store.")
        }
    }
    @IBAction func removeLemonFromLemonadeButtonPressed(sender: UIButton) {
        if currentGame.lemonsInLemonade >= 1 {
            currentGame.decreaseLemonsInLemonade()
            updateLabels()
            calculateLemonadeFlavor()
        } else {
            showAlertWithText(header: "No Lemons", message: "You can't remove lemons from a lemonade that doesn't have any lemons. Why don't you add some.")
        }
    }
    @IBAction func addIceCubeToLemonadeButtonPressed(sender: UIButton) {
        if currentGame.iceInInventory >= 1 {
            currentGame.increaseIceInLemonade()
            updateLabels()
            calculateLemonadeFlavor()
        } else {
            showAlertWithText(header: "Ice Is Nice", message: "Too bad you don't have any to add to the lemonade. Buy some more in the store.")
        }
    }
    @IBAction func removeIceCubeFromLemonadeButtonPressed(sender: UIButton) {
        if currentGame.iceInLemonade >= 1 {
            currentGame.decreaseIceInLemonade()
            updateLabels()
            calculateLemonadeFlavor()
        } else {
            showAlertWithText(header: "Iceless Lemonade", message: "There isn't any ice in the lemonade. You should probably add some.")
        }
    }
    
    func showAlertWithText(header: String = "Warning", message: String) {
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil ))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func showAlertWithGameOverButton(header: String = "Warning", message: String) {
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Restart Game", style: UIAlertActionStyle.Default, handler: {(action:UIAlertAction!) in
            println("test")
            self.resetGame()
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func calculateLemonadeFlavor() {
        if currentGame.lemonsInLemonade == 0 && currentGame.iceInLemonade == 0 {
            // nothing added
            lemonadeTasteDescriptionLabel.hidden = false
            lemonadeTasteDescriptionLabel.text = "Empty"
        } else if currentGame.lemonsInLemonade == 0 && currentGame.iceInLemonade > 0 {
            // no lemons
            lemonadeTasteDescriptionLabel.hidden = false
            lemonadeTasteDescriptionLabel.text = "Just Ice"
        } else if currentGame.lemonsInLemonade > 0 && currentGame.iceInLemonade == 0 {
            // no ice
            lemonadeTasteDescriptionLabel.hidden = false
            lemonadeTasteDescriptionLabel.text = "Just Lemons"
        } else {
            var lemonadeAcidityRatio = (currentGame.lemonsInLemonade / currentGame.iceInLemonade)
            var lemonadeFlavorProfile:String = ""
            if lemonadeAcidityRatio > 1 {
                lemonadeFlavorProfile = "Acidic"
            } else if lemonadeAcidityRatio == 1 {
                lemonadeFlavorProfile = "Balanced"
            } else {
                lemonadeFlavorProfile = "Diluted"
            }
            lemonadeTasteDescriptionLabel.hidden = false
            lemonadeTasteDescriptionLabel.text = "\(lemonadeFlavorProfile)"
        }
    }
    
    func resetGame() {
        currentGame.walletBalance = 10
        currentGame.lemonsInInventory = 0
        currentGame.iceInInventory = 0
        currentGame.day = 1
        updateLabels()
    }

    
    func updateLabels() {
        numberOfLemonsInLemonadeLabel.text = "\(currentGame.lemonsInLemonade)"
        numberOfIceCubesInLemonadeLabel.text = "\(currentGame.iceInLemonade)"
        numberOfLemonsInInventoryLabel.text = "\(currentGame.lemonsInInventory)"
        numberofIceCubesInInventoryLabel.text = "\(currentGame.iceInInventory)"
        walletBalanceLabel.text = "$\(currentGame.walletBalance)"
        dayLabel.text = "Day \(currentGame.day)"
        lemonadeTasteDescriptionLabel.hidden = true
        
    }

}

