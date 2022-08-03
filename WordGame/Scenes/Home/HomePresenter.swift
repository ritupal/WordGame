//
//  HomePresenter.swift
//  WordGame
//
//  Created by Kumari Ritu Pal on 26/07/22.
//

import Foundation

class HomePresenter {
    weak var viewController: HomeDisplayLogic?
}

extension HomePresenter: HomePresentationLogic {
    
    func loadTranslationPair(word: WordsModel, correctAttempts: Int, wrongAttempts: Int) {
        let infoViewModel = HomeInfoViewModel(engText: word.engText, spText: word.spanishText, correctAttempts: correctAttempts, wrongAttempts: wrongAttempts)
        let homeVM = HomeViewModel(homeInfoVM: infoViewModel)
        viewController?.loadLanguageWord(homeVM)
    }
    
    func onEndGame(score: Int) {
        viewController?.endGameWithScore(score)
    }
    
    func onQuitGame() {
        viewController?.closeAppOnGameQuit()
    }
}
