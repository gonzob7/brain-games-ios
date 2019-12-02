//
//  ViewController.swift
//  MindGames
//
//  Created by Gonzalo Birrueta on 11/27/19.
//  Copyright © 2019 Gonzalo Birrueta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var incorrectPopup: UIImageView!
    @IBOutlet weak var correctPopup: UIImageView!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var streakLabel: UILabel!
    @IBOutlet weak var colorMeaningLabel: UILabel!
    @IBOutlet weak var colorTextLabel: UILabel!
    
    let colorList = ["red","green","blue","purple"]
    var score = 0
    var streakEnabled = false
    var currentStreak = 0
    
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
    
    func correctAnimationPopup(){
        correctPopup.isHidden = false
        correctPopup.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.correctPopup.transform = .identity
        }) {(success) in
            UIView.animate(withDuration: 0.3,
                           animations: {
                            self.correctPopup.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            },
                           completion: { _ in
                            UIView.animate(withDuration: 0.3) {
                                self.correctPopup.transform = CGAffineTransform(scaleX: 0, y: 0)
                            }
            })
        }
    }
    
    func incorrectAnimationPopup(){
        incorrectPopup.isHidden = false
        incorrectPopup.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.incorrectPopup.transform = .identity
        }) {(success) in
            UIView.animate(withDuration: 0.3,
                           animations: {
                            self.incorrectPopup.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            },
                           completion: { _ in
                            UIView.animate(withDuration: 0.3) {
                                self.incorrectPopup.transform = CGAffineTransform(scaleX: 0, y: 0)
                            }
            })
        }
    }
    
    
    @IBAction func noButton(_ sender: Any) {
        if checkLogic(){
            incorrectAnimationPopup()
            score -= 10
            streakEnabled = false
        }else{
            correctAnimationPopup()
            score += 10
            streakEnabled = true
        }
    
        if streakEnabled{
            currentStreak += 1
        }else{
            currentStreak = 0
        }
        
        generatePair()
        scoreLabel.text = String(score)
        streakLabel.text = String(currentStreak)
    }
    
    @IBAction func yesButton(_ sender: Any) {
        if checkLogic(){
            correctAnimationPopup()
            score += 10
            streakEnabled = true
        }else{
            incorrectAnimationPopup()
            score -= 10
            streakEnabled = false
        }
        
        if streakEnabled{
            currentStreak += 1
        }else{
            currentStreak = 0
        }
        
        generatePair()
        scoreLabel.text = String(score)
        streakLabel.text = String(currentStreak)
        
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

