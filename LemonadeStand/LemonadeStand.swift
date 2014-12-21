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
    var lemonsInInventory = 5
    var lemonsInLemonade = 0
    var iceInInventory = 3
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
    
}