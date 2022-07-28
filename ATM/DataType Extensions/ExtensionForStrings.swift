//
//  ExtensionForStrings.swift
//  ATM
//
//  Created by Swift Developer on 22.07.22.
//

import Foundation

//this extention filters all the non integer characters from a string
extension String {
    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
}
