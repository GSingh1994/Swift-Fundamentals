//
//  ViewController.swift
//  Dicee-iOS13
//
//  Created by Angela Yu on 11/06/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var diceImageView1: UIImageView!
    @IBOutlet weak var diceImageView2: UIImageView!
    
    var leftDiceNumber = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        diceImageView1.image = UIImage(named: "DiceOne")
        diceImageView1.image = UIImage(named: "DiceOne")
        
    }

    @IBAction func rollButtonPressed(_ sender: UIButton) {
        let dice = ["DiceOne","DiceTwo","DiceThree","DiceFour","DiceFive","DiceSix"]
        
        diceImageView1.image = UIImage(named: dice[leftDiceNumber])
        
        leftDiceNumber += 1
    }
    
}

  
