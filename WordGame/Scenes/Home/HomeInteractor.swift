//
//  HomeInteractor.swift
//  WordGame
//
//  Created by Kumari Ritu Pal on 26/07/22.
//

import Foundation
import UIKit

class HomeInteractor: HomeDataStore {
    var presenter: HomePresentationLogic?
    var allWords: [WordsModel] = []
    var wordsForGame: [WordsModel] = []
    var correctAttempts = 0
    var wrongAttempts = 0
    var timer = Timer()
    
    //MARK: Private functions
    private func isWordListEmpty() -> Bool {
        return self.allWords.isEmpty
    }
    
    /// This function is to get the random word from the array
    /// - Parameter words: WordsModel
    /// - Returns: random word model
    private func getRandomWord(_ words: [WordsModel]) -> WordsModel {
        let random = Int.random(in: 0 ..< words.count)
        return words[random]
    }
    
    /// This function is to get the word pairs to be used in a Game( max is 15 which is mentioned in task)
    /// Here I am altering the tranlation so that word pair have wrong and right transalations (Reason why i need to to do is because json file have all the correct transalation and if i load the word pair from json then all the transalations will be correct and game needs to have 25% probability for correct transalation)
    /// - Parameter words: word model from json file
    private func getWordsforAGame(_ words: [WordsModel]) {
        if isWordListEmpty() { return }
        for i in 0 ..< Constants.maxWordPairForAGame {
            //here I am diving the max limit by 4 because correct trasalation propability is 25%
            let noOfCorrectWordPair = Constants.maxWordPairForAGame / 4
            if i >= noOfCorrectWordPair, i+1 < Constants.maxWordPairForAGame {
                var model = words[i]
                let nxtmodel = words[i+1]
                model.spanishText = nxtmodel.spanishText
                self.wordsForGame.append(model)
            } else {
                self.wordsForGame.append(words[i])
            }
        }
    }
    
    /// This function is to load a random word and pass it to the viewcontroller from presenter
    private func loadWordPair() {
        self.startTimer(isMadeAttempt: false)
        let randomWord = self.getRandomWord(self.wordsForGame)
        self.presenter?.loadTranslationPair(word: randomWord, correctAttempts: self.correctAttempts, wrongAttempts: self.wrongAttempts)
    }
    
    /// This function is increase wrongAttenmpt when time of 5 seconds has been passed
    private func increaseWrongAttempt() {
        self.wrongAttempts += 1
        self.loadWordPair()
    }
    
    /// This function is to start a game and load the word pair on the screen
    private func startAGame() {
        self.correctAttempts = 0
        self.wrongAttempts = 0
        self.loadWordPair()
    }
    
    /// This function is to start the timer of 5 seconds
    /// - Parameter isMadeAttempt: bool value if user has made any attempt or not
    private func startTimer(isMadeAttempt: Bool) {
        var timeLeft = Constants.maxTimeForAttempt
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            timeLeft -= 1
            if timeLeft == 0, !isMadeAttempt {
                self.increaseWrongAttempt()
                timer.invalidate()
            }
        })
    }
    
    private func resetTimer() {
        timer.invalidate()
        startTimer(isMadeAttempt: true)
    }
    
}

extension HomeInteractor: HomeBuisnessLogic {
    
    func fetchWords() {
        self.allWords = Bundle.main.decode(FileName.words.rawValue)
        getWordsforAGame(self.allWords)
        self.startAGame()
    }
    
    /// This function is to check whether the attempts which use has made is correct or not
    /// - Parameters:
    ///   - vm: home view model
    ///   - isCorrect: attempt value which user have selected
    func checkTransaltion(_ vm: HomeViewModel?, isCorrect: Bool)  {
        self.resetTimer()
        guard !isWordListEmpty(), let vm = vm else { return }
        let filteredVM = self.allWords.filter ({
            return $0.engText == vm.homeInfoVM.engText && $0.spanishText == vm.homeInfoVM.spanishText
        })
        if (isCorrect && !filteredVM.isEmpty) || (!isCorrect && filteredVM.isEmpty) {
            //correct Attempts when transation is correct and user chooses correct button OR When transation is wrong and user chooses Wrong button
            self.correctAttempts += 1
        } else  {
            //Wrong Attempts when transation is correct and user chooses Wrong button OR When transation is wrong and user chooses Correct button
            self.wrongAttempts += 1
        }
        self.loadWordPair()
    }

    func endGame() {
        resetTimer()
        self.presenter?.onEndGame(score: self.correctAttempts)
    }
    
    func restartGame() {
        self.startAGame()
    }
    
    func quitGame() {
        self.presenter?.onQuitGame()
    }
    
}
