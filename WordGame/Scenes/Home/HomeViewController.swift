//
//  HomeViewController.swift
//  WordGame
//
//  Created by Kumari Ritu Pal on 25/07/22.
//

import UIKit

protocol HomeDisplayLogic: AnyObject {
    func loadLanguageWord(_ word: WordsModel)
}

class HomeViewController: UIViewController {
    var interactor: HomeBuisnessLogic?
    
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
        self.defaultSetup()
        self.setupView()
        self.getLanguageWord()
    }
    
    //MARK:- Methods
    private func defaultSetup() {
        let viewController = self
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    private func setupView() {
        setDefaultText()
        self.lblCorrectAttempts.textColor = Constants.Style.mainColor
        self.lblWrongAttempts.textColor = Constants.Style.mainColor
        self.BtnWrong.backgroundColor = Constants.Style.mainColor
    }
    
    private func setDefaultText() {
        self.lblCorrectAttempts.text = Constants.HomeScreen.correctAttempts
        self.lblWrongAttempts.text = Constants.HomeScreen.wrongAttempts
        self.BtnCorrect.setTitle(Constants.HomeScreen.correct, for: .normal)
        self.BtnWrong.setTitle(Constants.HomeScreen.wrong, for: .normal)
    }
    
    private func setLanguageWords(word: WordsModel) {
        self.lblEnglishWord.text = word.engText
        self.lblSpanishWord.text = word.spanishText
    }
    
    private func getLanguageWord() {
        interactor?.fetchWords()
    }
    
    //MARK:- IBActions
    @IBAction func actionCorrectAnswer(_ sender: Any) {
    }
    
    @IBAction func actionWrongAction(_ sender: Any) {
    }
    
}

extension HomeViewController: HomeDisplayLogic {
    func loadLanguageWord(_ word: WordsModel) {
        self.setLanguageWords(word: word)
    }
}
