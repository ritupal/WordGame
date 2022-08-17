//
//  HomeViewModel.swift
//  WordGame
//
//  Created by Kumari Ritu Pal on 27/07/22.
//

import Foundation

class HomeViewModel {
    var homeInfoVM: HomeInfoViewModel
    
    init(homeInfoVM: HomeInfoViewModel){
        self.homeInfoVM = homeInfoVM
    }
}

class HomeInfoViewModel {
    let engText: String?
    let spanishText: String?
    let correctAttempts: Int
    let wrongAttempts: Int
    
    init(engText: String = "", spText: String = "", correctAttempts: Int, wrongAttempts: Int) {
        self.engText = engText
        self.spanishText = spText
        self.correctAttempts = correctAttempts
        self.wrongAttempts = wrongAttempts
    }
}

