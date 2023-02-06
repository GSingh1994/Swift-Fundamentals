//
//  ViewController.swift
//  Destini-iOS13
//
//  Created by Angela Yu on 08/08/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var storyLabel: UILabel!
    @IBOutlet weak var choice1Button: UIButton!
    @IBOutlet weak var choice2Button: UIButton!
    
    
    
    @IBAction func choiceMade(_ sender: UIButton) {
        if sender.currentTitle == stories[currentStory].choice1 {
            currentStory = 1
        } else {
            currentStory = 2
        }
        updateUI()
    }
    
    func updateUI() {
        storyLabel.text = stories[currentStory].title
        choice1Button.setTitle(stories[currentStory].choice1, for: .normal)
        choice2Button.setTitle(stories[currentStory].choice2, for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    
}

