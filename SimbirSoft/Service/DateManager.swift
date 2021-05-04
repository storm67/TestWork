//
//  DateManager.swift
//  SimbirSoft
//
//  Created by Storm67 on 29/04/2021.
//  Copyright © 2021 Storm67. All rights reserved.
//

import Foundation

enum CalendarSwitch {
    case month
    case day
    case year
}

final class DateManager {
    
    let now = Date()
    var calendar = Calendar.current
    var model: CalendarModel?
    
    func range(completion: @escaping (CalendarModel) -> Void) {
        calendar.locale = .some(.init(identifier: "ru-RU"))
        guard let range = calendar.range(of: .day, in: .month, for: now) else { return }
        let days = range.map { $0 }
        let year = calendar.component(.year, from: now)
        let month = calendar.component(.month, from: now)
        let day = calendar.component(.day, from: now)
        let weekday = calendar.component(.weekday, from: now)
        model = CalendarModel(days: days, year: year, current: month, months: calendar.shortStandaloneMonthSymbols, weekday: weekday,day: day, indent: 0)
        guard let model = model else { return }
        completion(model)
    }
    
    func daysReplace(for month: Int, year: Int) -> [Int] {
        let date = "\(year)-\(month)-01 14:20:20 +0000".getDateOfCurrent()
        return calendar.range(of: .day, in: .month, for: date)?.map { $0 } ?? []
    }
    
    func addHours() -> [Int] {
        var array = [Int]()
        for i in 0...24 {
            array.append(i)
        }
        return array
    }
    
    func getMainDateFromSince1970(start: Double, end: Double) -> ClosedRange<Int> {
        let startDate = Date(timeIntervalSince1970: start)
        let endDate = Date(timeIntervalSince1970: end)
        let dayStart = calendar.component(.day, from: startDate) 
        let dayEnd = calendar.component(.day, from: endDate)
        print(startDate,endDate,dayStart,dayEnd)
        return dayStart...dayEnd
    }
    
    func getHour(from: Double) -> Int {
        let date = Date(timeIntervalSince1970: from)
        return calendar.component(.hour, from: date)
    }
    
    func getHoursRange(from: Double, to: Double) -> ClosedRange<Int> {
        var calendarCurrent = Calendar.current
        let startDate = Date(timeIntervalSince1970: from)
        let endDate = Date(timeIntervalSince1970: to)
        guard let timeZone = TimeZone(secondsFromGMT: 0) else { return 0...3 }
        calendarCurrent.timeZone = timeZone
        let hourStart = calendarCurrent.component(.hour, from: startDate)
        let hourEnd = calendarCurrent.component(.hour, from: endDate)
        return hourStart...24
    }
    
    func getHoursRangeCorrect(from: Double, to: Double) -> ClosedRange<Int> {
        var calendarCurrent = Calendar.current
        let startDate = Date(timeIntervalSince1970: from)
        let endDate = Date(timeIntervalSince1970: to)
        guard let timeZone = TimeZone(secondsFromGMT: 0) else { return 0...3 }
        calendarCurrent.timeZone = timeZone
        let hourStart = calendarCurrent.component(.hour, from: startDate)
        let hourEnd = calendarCurrent.component(.hour, from: endDate)
        return 0...hourEnd
    }
    
    func getAnotherHoursRangeCorrect(from: Double, to: Double) -> ClosedRange<Int> {
        var calendarCurrent = Calendar.current
        let startDate = Date(timeIntervalSince1970: from)
        let endDate = Date(timeIntervalSince1970: to)
        guard let timeZone = TimeZone(secondsFromGMT: 0) else { return 0...3 }
        calendarCurrent.timeZone = timeZone
        let hourStart = calendarCurrent.component(.hour, from: startDate)
        let hourEnd = calendarCurrent.component(.hour, from: endDate)
        return hourStart...hourEnd
    }
    
    func getDay(from: Double) -> Int {
        let date = Date(timeIntervalSince1970: from)
        return calendar.component(.day, from: date)
    }
    
    func getYear(from: Double) -> Int {
        let date = Date(timeIntervalSince1970: from)
        return calendar.component(.year, from: date)
    }
    
    func getMonth(from: Double) -> Int {
        let date = Date(timeIntervalSince1970: from)
        return calendar.component(.month, from: date)
    }
    
    func previousMonth(year: Int, month: Int) -> Int {
        var month = month
        if month == 0 { month = 12 }
        let date = "\(year)-\(month)-01 14:20:20 +0000"
        return date.getMonth()
    }
    
    func getWeekday(year: Int, month: Int, day: Int) -> Int {
        let date = "\(year)-\(month)-\(day) 17:20:20 +0000"
        return date.getDayOfWeek() - 1
    }
    
}


