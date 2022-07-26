//
//  HomePresenter.swift
//  WordGame
//
//  Created by Kumari Ritu Pal on 26/07/22.
//

import Foundation

protocol HomePresentationLogic {
    func onWordFetchSucceed(word: WordsModel)
}

class HomePresenter: HomePresentationLogic {
    weak var viewController: HomeDisplayLogic?
    
    func onWordFetchSucceed(word: WordsModel) {
        viewController?.loadLanguageWord(word)
    }
}
