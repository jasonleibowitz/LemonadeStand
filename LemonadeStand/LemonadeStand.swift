//
//  LemonadeStand.swift
//  LemonadeStand
//
//  Created by Jason Leibowitz on 12/20/14.
//  Copyright (c) 2014 Jason Leibowitz. All rights reserved.
//

import Foundation
import UIKit

class LemonadeStand {
    var walletBalance = 10
    var lemonsInInventory = 0
    var lemonsInLemonade = 0
    var iceInInventory = 0
    var iceInLemonade = 0
    var day = 1
    
    func increaseLemonsInLemonade() {
        lemonsInInventory -= 1
        lemonsInLemonade += 1
    }
    
    func decreaseLemonsInLemonade() {
        lemonsInInventory += 1
        lemonsInLemonade -= 1
    }
    
    func increaseIceInLemonade() {
        iceInInventory -= 1
        iceInLemonade += 1
    }
    
    func decreaseIceInLemonade() {
        iceInInventory += 1
        iceInLemonade -= 1
    }
    
    func purchaseLemon() {
        lemonsInInventory += 1
        walletBalance -= 2
    }
    
    func returnLemon() {
        lemonsInInventory -= 1
        walletBalance += 2
    }
    
    func purchaseIce() {
        iceInInventory += 1
        walletBalance -= 1
    }
    
    func returnIce() {
        iceInInventory -= 1
        walletBalance += 1
    }
    
    func calculateDailyProfits() -> (profits:Int, customers: Int, weather:Int) {
        var daysProfits = 0
        var lemonadeAcidityRatio:Double = (Double(lemonsInLemonade) / Double(iceInLemonade))
        println("lemonade acidity ratio: \(lemonadeAcidityRatio)")
        
        // Initialize number of customers
        var randomNumberOfCustomers = Int(arc4random_uniform(UInt32(10)))
        println("random number of customers: \(randomNumberOfCustomers)")
        
        // Initialize random weather
        var weather = Int(arc4random_uniform(UInt32(3)))
        switch weather {
        case 0: // cold weather
            randomNumberOfCustomers -= 3
            if randomNumberOfCustomers < 0 { randomNumberOfCustomers = 0 }
            println("The weather today is cold. You have \(randomNumberOfCustomers) customers visiting you today.")
        case 1: // fair weather
            randomNumberOfCustomers += 0
            println("The weather today is fair. No change in customers.")
        case 2: // warm weather
            randomNumberOfCustomers += 3
            println("It's a beautifully warm day today. You now have \(randomNumberOfCustomers) customers")
        default:
            randomNumberOfCustomers += 0
        }
        
        // Initialize customer preference array
        var customerPreferenceArray:Array<Double> = []
        for (var i = randomNumberOfCustomers; i > 0; --i) {
            customerPreferenceArray.append(Double(arc4random()) / Double(0x100000000))
        }
        println("customer preference ratio: \(customerPreferenceArray)")
        println("customer pref count - \(customerPreferenceArray.count)")
        
        // Calculate sales
        for (var j = 0; j < customerPreferenceArray.count; ++j) {
            if customerPreferenceArray[j] < 0.4 && lemonadeAcidityRatio > 1 {
                daysProfits += 1
            } else if ((customerPreferenceArray[j] >= 0.4 && customerPreferenceArray[j] <= 0.6) && lemonadeAcidityRatio == 1) {
                daysProfits += 1
            } else if customerPreferenceArray[j] > 0.6 && lemonadeAcidityRatio < 1 {
                daysProfits += 1
            }
        }
        
        // update currentGame variables
        
        walletBalance += daysProfits
        lemonsInLemonade = 0
        iceInLemonade = 0
        day += 1
        
        return (daysProfits, randomNumberOfCustomers, weather)
    }
    
}