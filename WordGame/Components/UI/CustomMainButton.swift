//
//  CustomMainButton.swift
//  WordGame
//
//  Created by Kumari Ritu Pal on 26/07/22.
//

import Foundation
import UIKit

class CustomMainButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.backgroundColor = Constants.Style.mainColor
        self.setTitleColor(Constants.Style.buttonTextColor, for: .normal)
        self.layer.cornerRadius = 4.0
        self.layer.masksToBounds = true
    }
}
