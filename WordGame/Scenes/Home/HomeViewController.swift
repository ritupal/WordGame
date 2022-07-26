//
//  HomeViewController.swift
//  WordGame
//
//  Created by Kumari Ritu Pal on 25/07/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var lblCorrectAttempts: UILabel!
    @IBOutlet weak var lblWrongAttempts: UILabel!
    @IBOutlet weak var lblSpanishWord: UILabel!
    @IBOutlet weak var lblEnglishWord: UILabel!
    @IBOutlet weak var BtnCorrect: CustomMainButton!
    @IBOutlet weak var BtnWrong: UIButton!
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    //MARK:- Methods
    func setupView() {
        setDefaultText()
        self.lblCorrectAttempts.textColor = Constants.Style.mainColor
        self.lblWrongAttempts.textColor = Constants.Style.mainColor
        self.BtnWrong.backgroundColor = Constants.Style.mainColor
    }
    
    func setDefaultText() {
        self.lblCorrectAttempts.text = Constants.HomeScreen.correctAttempts
        self.lblWrongAttempts.text = Constants.HomeScreen.wrongAttempts
        self.BtnCorrect.setTitle(Constants.HomeScreen.correct, for: .normal)
        self.BtnWrong.setTitle(Constants.HomeScreen.wrong, for: .normal)
    }
    
    //MARK:- IBActions
    @IBAction func actionCorrectAnswer(_ sender: Any) {
    }
    
    @IBAction func actionWrongAction(_ sender: Any) {
    }
    
}
