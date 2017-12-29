//
//  LoginController.swift
//  KyrptoWallet
//
//  Created by MetroStar on 12/24/17.
//  Copyright © 2017 TamerBader. All rights reserved.
//

import UIKit
class LoginController: UIViewController {
    
    private var pin:String = ""
    private var currState:Int = 0
    
    @IBOutlet weak var pinOne: UIImageView!
    @IBOutlet weak var pinTwo: UIImageView!
    @IBOutlet weak var pinThree: UIImageView!
    @IBOutlet weak var pinFour: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updatePinImages(state: currState)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pinPressed(_ sender: UIButton) {
        if (sender.tag >= 0 && sender.tag < 10 && currState < 4) {
            pin += "\(sender.tag)"
            currState += 1
            updatePinImages(state: currState)
            if (currState == 4) {
                print("Your Passcode is ",pin)
            }
        }
        
        if (sender.tag == 10 && currState > 0 && currState < 4) {
            pin = String(pin.dropLast())
            currState -= 1
            updatePinImages(state: currState)
        }
    }
    
    func updatePinImages(state:Int) {
        switch state {
            
        case 0:
            pinOne.image = #imageLiteral(resourceName: "PinEmpty")
            pinTwo.image = #imageLiteral(resourceName: "PinEmpty")
            pinThree.image = #imageLiteral(resourceName: "PinEmpty")
            pinFour.image = #imageLiteral(resourceName: "PinEmpty")
        case 1:
            pinOne.image = #imageLiteral(resourceName: "PinFill")
            pinTwo.image = #imageLiteral(resourceName: "PinEmpty")
            pinThree.image = #imageLiteral(resourceName: "PinEmpty")
            pinFour.image = #imageLiteral(resourceName: "PinEmpty")
        case 2:
            pinOne.image = #imageLiteral(resourceName: "PinFill")
            pinTwo.image = #imageLiteral(resourceName: "PinFill")
            pinThree.image = #imageLiteral(resourceName: "PinEmpty")
            pinFour.image = #imageLiteral(resourceName: "PinEmpty")
        case 3:
            pinOne.image = #imageLiteral(resourceName: "PinFill")
            pinTwo.image = #imageLiteral(resourceName: "PinFill")
            pinThree.image = #imageLiteral(resourceName: "PinFill")
            pinFour.image = #imageLiteral(resourceName: "PinEmpty")
        case 4:
            pinOne.image = #imageLiteral(resourceName: "PinFill")
            pinTwo.image = #imageLiteral(resourceName: "PinFill")
            pinThree.image = #imageLiteral(resourceName: "PinFill")
            pinFour.image = #imageLiteral(resourceName: "PinFill")
            createUserAccounts()
        default:
            pinOne.image = #imageLiteral(resourceName: "PinEmpty")
            pinTwo.image = #imageLiteral(resourceName: "PinEmpty")
            pinThree.image = #imageLiteral(resourceName: "PinEmpty")
            pinFour.image = #imageLiteral(resourceName: "PinEmpty")
        }
    }
    
    func createUserAccounts() {
        savePin()
        performSegue(withIdentifier: "drawingBoard", sender: nil)
        
    }
    
    func savePin() {
        let keychain = KeychainSwift()
        keychain.set(pin, forKey: "pin")
    }
    
    
    
}

