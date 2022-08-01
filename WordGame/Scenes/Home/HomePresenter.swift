//
//  HomePresenter.swift
//  WordGame
//
//  Created by Kumari Ritu Pal on 26/07/22.
//

import Foundation

protocol HomePresentationLogic {
//    func onWordFetchSucceed(word: WordsModel)
//    func onCorrectAttempt(word: WordsModel, correctAttempts: Int, wrongAttempts: Int)
//    func onWrongAttempt(word: WordsModel, correctAttempts: Int, wrongAttempts: Int)
    func loadTranslationPair(word: WordsModel, correctAttempts: Int, wrongAttempts: Int)
}

class HomePresenter {
    weak var viewController: HomeDisplayLogic?
}

extension HomePresenter: HomePresentationLogic {
    
//    func onWordFetchSucceed(word: WordsModel) {
//        let infoViewModel = HomeInfoViewModel(engText: word.engText, spText: word.spanishText, correctAttempts: word.correctAttempts, wrongAttempts: word.wrongAttempts)
//        let homeVM = HomeViewModel(homeInfoVM: infoViewModel)
//        viewController?.loadLanguageWord(homeVM)
//    }
    
    func loadTranslationPair(word: WordsModel, correctAttempts: Int, wrongAttempts: Int) {
        let infoViewModel = HomeInfoViewModel(engText: word.engText, spText: word.spanishText, correctAttempts: correctAttempts, wrongAttempts: wrongAttempts)
        let homeVM = HomeViewModel(homeInfoVM: infoViewModel)
        viewController?.loadLanguageWord(homeVM)
    }
    
//    func onWrongAttempt(word: WordsModel, correctAttempts: Int, wrongAttempts: Int) {
//        let infoViewModel = HomeInfoViewModel(engText: word.engText, spText: word.spanishText, correctAttempts: correctAttempts, wrongAttempts: wrongAttempts)
//        let homeVM = HomeViewModel(homeInfoVM: infoViewModel)
//        viewController?.loadLanguageWord(homeVM)
//    }
}
