//
//  HomeInteractor.swift
//  WordGame
//
//  Created by Kumari Ritu Pal on 26/07/22.
//

import Foundation

protocol HomeBuisnessLogic {
    func fetchWords()
}

class HomeInteractor: HomeBuisnessLogic {
    var presenter: HomePresentationLogic?
    var words: [WordsModel] = []
    
    func fetchWords() {
        self.words = Bundle.main.decode(fileName.words.rawValue)
        let randomWord = getRandomWord(self.words)
        self.presenter?.onWordFetchSucceed(word: randomWord)
    }
    
    //TODO:- NEED of this
    private func isWordListEmpty() -> Bool {
        return self.words.isEmpty
    }
    
    private func getRandomWord(_ words: [WordsModel]) -> WordsModel {
        let random = Int.random(in: 0 ..< words.count)
        return words[random]
    }
}
