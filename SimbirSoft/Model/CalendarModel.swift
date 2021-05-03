//
//  CalendarModel.swift
//  SimbirSoft
//
//  Created by Storm67 on 30/04/2021.
//  Copyright © 2021 Storm67. All rights reserved.
//

import Foundation

final class CalendarModel: Codable {
    var months: [String]
    var days: [Int]?
    var year: Int
    var current: Int
    var weekday: Int
    var day: Int
    var indent: Int?
    init(days: [Int], year: Int, current: Int, months: [String], weekday: Int, day: Int, indent: Int) {
        self.days = days
        self.year = year
        self.current = current - 1
        self.months = months
        self.weekday = weekday
        self.day = day
        self.indent = indent
    }
    
}
