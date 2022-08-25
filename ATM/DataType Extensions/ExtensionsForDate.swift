//
//  ExtensionsForDate.swift
//  ATM
//
//  Created by Swift Developer on 24.08.22.
//

import Foundation

extension Date  {
    static func from(year: Int, month: Int, day: Int) -> Date? {
            let calendar = Calendar(identifier: .gregorian)
            var dateComponents = DateComponents()
            dateComponents.year = year
            dateComponents.month = month
            dateComponents.day = day
        return calendar.date(from: dateComponents) ?? nil
    }
}
