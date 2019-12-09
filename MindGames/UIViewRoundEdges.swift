//
//  UIViewRoundEdges.swift
//  MindGames
//
//  Created by Gonzalo Birrueta on 12/8/19.
//  Copyright © 2019 Gonzalo Birrueta. All rights reserved.
//

import Foundation
import UIKit

class UIViewRoundEdges: UIView {
override func draw(_ rect: CGRect) {
    self.layer.cornerRadius = (self.layer.frame.height/2)
    self.layer.masksToBounds = true
    }
}
