//
//  StoryboardHelper.swift
//  WordGame
//
//  Created by Kumari Ritu Pal on 02/08/22.
//

import UIKit
// This enum is to get the storyboard
enum StoryboardName: String {
    case main = "Main"
    
    var storyboard: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: nil)
    }
    
    func instantiateInitialViewController<T: UIViewController>() -> T {
        return storyboard.instantiateInitialViewController() as! T
    }
}

// This protocol is to instantiate the view controller of the storybard
protocol StoryboardHelper {
    static func instantiate<T: UIViewController>(_ type: T.Type, storyboard storyboardName: StoryboardName, identifier: String?, isPad: Bool?) -> T
}

extension StoryboardHelper where Self: UIViewController {
    static func instantiate<T: UIViewController>(_ type: T.Type, storyboard storyboardName: StoryboardName = .main, identifier: String? = nil, isPad: Bool? = false) -> T {
        
        let storyboardIdentifier: String
        if let identifier = identifier {
            storyboardIdentifier = identifier
        } else {
            let fullName = NSStringFromClass(T.self)
            storyboardIdentifier = fullName.components(separatedBy: ".").last!
        }
        let storyboardNameValue = self.getStoryboardName(storyboardName, isIpad: (isPad ?? false))
        let storyboard = UIStoryboard(name: storyboardNameValue, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! T
    }
    
    static func instantiateInitial<T: UIViewController>(_ storyboardName: StoryboardName = .main) -> T {
        return storyboardName.instantiateInitialViewController()
    }
    
    private static func getStoryboardName(_ storyboardName: StoryboardName, isIpad: Bool) -> String {
        return isIpad ? "\(storyboardName.rawValue)_iPad" : storyboardName.rawValue
    }
}
