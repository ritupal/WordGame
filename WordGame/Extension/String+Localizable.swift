//
//  String+Localizable.swift
//  WordGame
//
//  Created by Kumari Ritu Pal on 25/07/22.
//

import Foundation

extension String {
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, bundle: bundle, value: "**\(self)**", comment: "")
    }
}
