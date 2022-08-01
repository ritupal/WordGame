//
//  HomeInteractor.swift
//  WordGame
//
//  Created by Kumari Ritu Pal on 26/07/22.
//

import Foundation

protocol HomeBuisnessLogic {
    func fetchWords()
    func checkTransaltion(_ vm: HomeViewModel?, isCorrect: Bool)
}

protocol HomeDataStore {
    var allWords: [WordsModel] { get }
    var wordsForGame: [WordsModel] { get }
    
}

class HomeInteractor: HomeDataStore {
    var presenter: HomePresentationLogic?
    var allWords: [WordsModel] = []
    var wordsForGame: [WordsModel] = []
    var correctAttempts = 0
    var wrongAttempts = 0
    
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
    
}

extension HomeInteractor: HomeBuisnessLogic {
    func fetchWords() {
        self.allWords = Bundle.main.decode(fileName.words.rawValue)
        getWordsforAGame(self.allWords)
        let randomWord = getRandomWord(self.wordsForGame)
        self.presenter?.loadTranslationPair(word: randomWord, correctAttempts: 0, wrongAttempts: 0)
    }
    
    func checkTransaltion(_ vm: HomeViewModel?, isCorrect: Bool)  {
        guard !isWordListEmpty(), let vm = vm else { return }
        let filteredVM = self.allWords.filter ({
            return $0.engText == vm.homeInfoVM.engText && $0.spanishText == vm.homeInfoVM.spanishText
        })
        let randomWord = getRandomWord(self.wordsForGame)
        if (isCorrect && !filteredVM.isEmpty) || (!isCorrect && filteredVM.isEmpty) {
            //correct Attempts when transation is correct and user chooses correct button OR When transation is wrong and user chooses Wrong button
            self.correctAttempts += 1
        } else  {
            //Wrong Attempts when transation is correct and user chooses Wrong button OR When transation is wrong and user chooses Correct button
            self.wrongAttempts += 1
        }
        self.presenter?.loadTranslationPair(word: randomWord, correctAttempts: self.correctAttempts, wrongAttempts: self.wrongAttempts)
    }
    
}
