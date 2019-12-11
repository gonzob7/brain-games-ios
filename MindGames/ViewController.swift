//
//  ViewController.swift
//  MindGames
//
//  Created by Gonzalo Birrueta on 11/27/19.
//  Copyright © 2019 Gonzalo Birrueta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: IBOutlets
    
    @IBOutlet weak var colorTextView: DesignableButton!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!

    @IBOutlet weak var incorrectPopup: UIImageView!
    @IBOutlet weak var correctPopup: UIImageView!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var streakLabel: UILabel!
    @IBOutlet weak var colorMeaningLabel: UILabel!
    @IBOutlet weak var colorTextLabel: UILabel!
            
    //MARK: Variables

    var gameActive = false
    var finalScore: String = ""
    let colorList = ["red","green","blue","purple"]
    var score = 0
    var streakEnabled = false
    var currentStreak = 0
    var randomColor = UIColor.random(from: [.red, .yellow, .green, .blue, .purple])

    
    //MARK: ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        gameActive = true
        generatePair()
        startCountdown()
        resetScore()
    }
    

    
    //MARK: Functions
    
    func startCountdown(){
        var time = 20
        self.timeLabel.text = String(time)
        self.timeLabel.textColor = .green
        let generator = UINotificationFeedbackGenerator()
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            time -= 1
            self.timeLabel.text = String(time)
            
            if time == 15{
                self.timeLabel.textColor = .yellow
            } else if time <= 10 && time > 0{
                self.timeLabel.textColor = .red
                self.timeLabel.shake()
                generator.notificationOccurred(.error)
            } else if time == 0{
                timer.invalidate()
                self.finalScore = self.scoreLabel.text!
                self.gameOver()
                self.gameActive = false
                
                
            }
        }
    }
    
    func generatePair(){
        randomColor = UIColor.random(from: [.red, .green, .blue, .purple])
        colorTextLabel.textColor = randomColor
        colorTextLabel.text = colorList.randomElement()
        colorMeaningLabel.text = colorList.randomElement()
        colorTextView.layer.borderColor = randomColor?.cgColor
        
    }
    
    
    func checkLogic() -> Bool{
        let colorMeaning = colorMeaningLabel.text!
        if colorMeaning == randomColor?.name{
            return true
        }else{
            return false
        }
    }
    
    func resetScore(){
        score = 0
        scoreLabel.text = String(score)
        currentStreak = 0
        streakLabel.text = String(currentStreak)
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
    
    
    func gameOver(){
        print(score)
        self.performSegue(withIdentifier: "endScreen", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as! ResultsViewController
        vc.finalScore = self.finalScore
    }
    
    
    //MARK: IBActions
    
    @IBAction func noButton(_ sender: Any) {
        if gameActive{
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
    }
    
    @IBAction func yesButton(_ sender: Any) {
        if gameActive{
            if checkLogic(){
                correctAnimationPopup()
                score += 10
                streakEnabled = true
            }else{
                if score > 0{
                    incorrectAnimationPopup()
                    score -= 10
                    streakEnabled = false
                }else{
                    incorrectAnimationPopup()
                    streakEnabled = false
                }

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
    
    
    
}

//MARK: Extensions
extension UIColor {
    static func random(from colors: [UIColor]) -> UIColor? {
        return colors.randomElement()
    }
}

extension UIColor {
    var name: String? {
        switch self {
        case UIColor.red: return "red"
        case UIColor.green: return "green"
        case UIColor.blue: return "blue"
        case UIColor.cyan: return "cyan"
        case UIColor.yellow: return "yellow"
        case UIColor.magenta: return "magenta"
        case UIColor.orange: return "orange"
        case UIColor.purple: return "purple"
        default: return nil
        }
    }
}

