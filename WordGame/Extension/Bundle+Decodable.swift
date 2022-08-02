//
//  Bundle+Decodable.swift
//  WordGame
//
//  Created by Kumari Ritu Pal on 26/07/22.
//

import Foundation

enum FileName: String {
    case words = "words"
    case mockWord = "wordMock"
}

extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: "json") else {
            fatalError("Unable to locate \(file) in bundle")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Unable to load \(file) in bundle")
        }
        
        let decoder = JSONDecoder()
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Unable to decode \(file) in bundle")
        }
        return loaded
    }
}
