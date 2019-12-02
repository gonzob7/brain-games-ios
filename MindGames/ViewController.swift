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
    
    let colorList = ["red","green","blue","purple"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        generatePair()
    }

    var randomColor = UIColor.random(from: [.red, .yellow, .green, .blue, .purple])
    
    
    func generatePair(){
        randomColor = UIColor.random(from: [.red, .green, .blue, .purple])
        colorTextLabel.textColor = randomColor
        colorTextLabel.text = colorList.randomElement()
        colorMeaningLabel.text = colorList.randomElement()
    }
    
    
    func checkLogic() -> Bool{
        let colorMeaning = colorMeaningLabel.text!
        if colorMeaning == randomColor?.name{
            return true
        }else{
            return false
        }
    }
    
    @IBAction func noButton(_ sender: Any) {
        if checkLogic(){
            print("Incorrect")
        }else{
            print("Correct")
        }
        generatePair()
    }
    
    @IBAction func yesButton(_ sender: Any) {
        if checkLogic(){
            print("Correct")
        }else{
            print("Incorrect")
        }
        generatePair()
    }
}

extension UIColor {
    static func random(from colors: [UIColor]) -> UIColor? {
        return colors.randomElement()
    }
}

extension UIColor {
    var name: String? {
        switch self {
        case UIColor.black: return "black"
        case UIColor.darkGray: return "darkGray"
        case UIColor.lightGray: return "lightGray"
        case UIColor.white: return "white"
        case UIColor.gray: return "gray"
        case UIColor.red: return "red"
        case UIColor.green: return "green"
        case UIColor.blue: return "blue"
        case UIColor.cyan: return "cyan"
        case UIColor.yellow: return "yellow"
        case UIColor.magenta: return "magenta"
        case UIColor.orange: return "orange"
        case UIColor.purple: return "purple"
        case UIColor.brown: return "brown"
        default: return nil
        }
    }
}

