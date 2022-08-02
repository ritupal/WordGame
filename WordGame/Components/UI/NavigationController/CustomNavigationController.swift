//
//  CustomNavigationController.swift
//  WordGame
//
//  Created by Kumari Ritu Pal on 02/08/22.
//

import UIKit

class CustomNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        setupStyle()
    }
    
    private func setupStyle(){
        self.navigationBar.barStyle = Constants.Styles.tabbarStyleColor
        self.navigationBar.isTranslucent = true
        self.navigationBar.isHidden = true
        self.navigationBar.tintColor = Constants.Styles.mainColor
        let textAttributes = [NSAttributedString.Key.foregroundColor:Constants.Styles.mainColor]
        self.navigationBar.titleTextAttributes = textAttributes
    }
    
}
