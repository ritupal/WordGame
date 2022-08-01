//
//  UIButton+Main.swift
//  WordGame
//
//  Created by Kumari Ritu Pal on 26/07/22.
//

import Foundation
import UIKit

@IBDesignable extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {return layer.cornerRadius}
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue>0
        }
    }
}
