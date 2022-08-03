//
//  HomeWireFrame.swift
//  WordGame
//
//  Created by Kumari Ritu Pal on 03/08/22.
//

import Foundation
//this is place where all the protocols which have been used in home scene are listed

protocol HomeDisplayLogic: AnyObject {
    func loadLanguageWord(_ viewModel: HomeViewModel)
    func endGameWithScore(_ score: Int)
    func closeAppOnGameQuit()
}

protocol HomeBuisnessLogic {
    func fetchWords()
    func checkTransaltion(_ vm: HomeViewModel?, isCorrect: Bool)
    func endGame()
    func restartGame()
    func quitGame()
}

protocol HomeDataStore {
    var allWords: [WordsModel] { get }
    var wordsForGame: [WordsModel] { get }
    
}

protocol HomePresentationLogic {
    func loadTranslationPair(word: WordsModel, correctAttempts: Int, wrongAttempts: Int)
    func onEndGame(score: Int)
    func onQuitGame()
}
