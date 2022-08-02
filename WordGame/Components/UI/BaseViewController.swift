//
//  BaseViewController.swift
//  WordGame
//
//  Created by Kumari Ritu Pal on 01/08/22.
//

import UIKit

protocol BaseViewDisplayLogic{
    
}

class BaseViewController: UIViewController, BaseViewDisplayLogic {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func showAlertView() {
        let alert = UIAlertController(title: "", message: "You have score 12 points", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Quit", style: .default, handler: { _ in
            //Cancel Action
        }))
        alert.addAction(UIAlertAction(title: "Restart",
                                      style: .default,
                                      handler: {(_: UIAlertAction!) in
            //Sign out action
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}



