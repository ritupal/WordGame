//
//  Constant.swift
//  WordGame
//
//  Created by Kumari Ritu Pal on 25/07/22.
//

import Foundation
import UIKit

struct Constants {
    static let maxWordPairForAGame = 15
    static let maxWrongLimit = 3
    static let maxTimeForAttempt = 5
    
    struct HomeScreen {
        static let correctAttempts = "home_correct_attemps".localized()
        static let wrongAttempts = "home_wrong_attemps".localized()
        static let correct = "home_correct_text".localized()
        static let wrong = "home_wrong_text".localized()
    }
    struct Styles {
        static let mainColor: UIColor = #colorLiteral(red: 0.9294117647, green: 0.431372549, blue: 0.262745098, alpha: 1)
        static let buttonTextColor: UIColor = .white
        static let backGroundColor: UIColor = .white
        static let tabbarStyleColor: UIBarStyle = .black

    }
    
    struct Alert {
        static let title = "alert_title".localized()
        static let message = "alert_message".localized()
        static let leftButtonTitle = "alert_no_title".localized()
        static let rightButtonTitle = "alert_yes_title".localized()
        static let points = "points".localized()
    }
}
