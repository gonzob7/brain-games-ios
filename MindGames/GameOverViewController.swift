//
//  GameOverViewController.swift
//  MindGames
//
//  Created by Gonzalo Birrueta on 12/9/19.
//  Copyright © 2019 Gonzalo Birrueta. All rights reserved.
//

import Foundation
import UIKit

class GameOverViewController: UIViewController {
    
    @IBOutlet weak var finalScoreLabel: UILabel!
    
    override func viewDidLoad() {
    }
    
    @IBAction func playAgain(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    

    
}
