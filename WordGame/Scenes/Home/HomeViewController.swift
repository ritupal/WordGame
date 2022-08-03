//
//  HomeViewController.swift
//  WordGame
//
//  Created by Kumari Ritu Pal on 25/07/22.
//

import UIKit

class HomeViewController: UIViewController, StoryboardHelper {
    var interactor: HomeBuisnessLogic?
    var viewModel: HomeViewModel?
    
    //MARK:- IBOutlets
    @IBOutlet weak var lblCorrectAttempts: UILabel!
    @IBOutlet weak var lblWrongAttempts: UILabel!
    @IBOutlet weak var lblSpanishWord: UILabel!
    @IBOutlet weak var lblEnglishWord: UILabel!
    @IBOutlet weak var BtnCorrect: UIButton!
    @IBOutlet weak var BtnWrong: UIButton!
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.defaultSetup()
        self.setupView()
        self.getLanguageWord()
    }
    
    //MARK:- Methods
    func defaultSetup() {
        let viewController = self
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    private func setupView() {
        self.lblCorrectAttempts.textColor = Constants.Styles.mainColor
        self.lblWrongAttempts.textColor = Constants.Styles.mainColor
        self.BtnWrong.backgroundColor = Constants.Styles.mainColor
        setDefaultText()
    }
    
    private func setDefaultText() {
        self.lblCorrectAttempts.text = Constants.HomeScreen.correctAttempts
        self.lblWrongAttempts.text = Constants.HomeScreen.wrongAttempts
        self.BtnCorrect.setTitle(Constants.HomeScreen.correct, for: .normal)
        self.BtnWrong.setTitle(Constants.HomeScreen.wrong, for: .normal)
    }
    
    private func setLanguageWords(vm: HomeInfoViewModel) {
        self.lblEnglishWord.text = vm.engText
        self.lblSpanishWord.text = vm.spanishText
        self.lblCorrectAttempts.text = Constants.HomeScreen.correctAttempts + "\(vm.correctAttempts)"
        self.lblWrongAttempts.text = Constants.HomeScreen.wrongAttempts + "\(vm.wrongAttempts)"
        self.animateSpanishText()
        self.endGame(vm: vm)
    }
    
    private func getLanguageWord() {
        interactor?.fetchWords()
    }
    
    func endGame(vm: HomeInfoViewModel) {
        if vm.correctAttempts == Constants.maxWordPairForAGame || vm.wrongAttempts == Constants.maxWrongLimit {
            interactor?.endGame()
        }
    }
    
    //MARK:- IBActions
    @IBAction func actionCorrectAnswer(_ sender: Any) {
        interactor?.checkTransaltion(self.viewModel, isCorrect: true)
    }
    
    @IBAction func actionWrongAction(_ sender: Any) {
        interactor?.checkTransaltion(self.viewModel, isCorrect: false)
    }
    
    func animateSpanishText() {
        UIView.animate(withDuration: Constants.maxTimeForAttempt, delay: 0.0, options: []) {
            self.lblSpanishWord.frame.origin.y += self.view.frame.height/2
        } completion: { _ in
            self.lblSpanishWord.frame.origin.y += 0
        }
    }
}

extension HomeViewController: HomeDisplayLogic {
    func loadLanguageWord(_ viewModel: HomeViewModel) {
        self.viewModel = viewModel
        self.setLanguageWords(vm: viewModel.homeInfoVM)
    }
    
    func endGameWithScore(_ score: Int) {
        let message = "\(Constants.Alert.message) \(score) \(Constants.Alert.points)"
        let alert = UIAlertController(title: Constants.Alert.title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.Alert.leftButtonTitle, style: .default, handler: {[weak self] _ in
            self?.interactor?.quitGame()
        }))
        alert.addAction(UIAlertAction(title: Constants.Alert.rightButtonTitle,
                                      style: .default,
                                      handler: {[weak self](_: UIAlertAction!) in
            self?.interactor?.restartGame()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func closeAppOnGameQuit() {
        exit(0)
    }
}
