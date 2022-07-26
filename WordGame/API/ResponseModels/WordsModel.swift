//
//  WordsModel.swift
//  WordGame
//
//  Created by Kumari Ritu Pal on 26/07/22.
//

import Foundation

struct WordsModel: Codable {
    let engText: String
    let spanishText: String
    
    private enum codingKeys: String, CodingKey {
        case engText = "text_eng", spanishText = "text_spa"
    }
}
