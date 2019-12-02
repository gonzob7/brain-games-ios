//
//  ViewController.swift
//  MindGames
//
//  Created by Gonzalo Birrueta on 11/27/19.
//  Copyright © 2019 Gonzalo Birrueta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var colorMeaningLabel: UILabel!
    
    @IBOutlet weak var colorTextLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    var randomColor = UIColor.random(from: [.red, .yellow, .green, .blue, .purple])
    
    @IBAction func noButton(_ sender: Any) {
        randomColor = UIColor.random(from: [.red, .yellow, .green, .blue, .purple])
        colorTextLabel.textColor = randomColor
    }
    
    @IBAction func yesButton(_ sender: Any) {
        print("Yes")
    }
    
}

extension UIColor {
    static func random(from colors: [UIColor]) -> UIColor? {
        return colors.randomElement()
    }
}

