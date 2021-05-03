//
//  Extension.swift
//  SimbirSoft
//
//  Created by Storm67 on 30/04/2021.
//  Copyright © 2021 Storm67. All rights reserved.
//

import Foundation


extension String {
    
    func getMonth() -> Int {
        let formatter = DateFormatter()
        formatter.timeZone = .some(.current)
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
        guard let todayDate = formatter.date(from: self) else { return 0 }
        let myCalendar = Calendar(identifier: .gregorian)
        guard let weekDay = myCalendar.range(of: .day, in: .month, for: todayDate) else { return 0 }
        return weekDay.count
    }
    
    func getDateOfCurrent() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
        guard let todayDate = formatter.date(from: self) else { return Date() }
        return todayDate
    }
    
    func getDayOfWeek() -> Int {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
        guard let string = formatter.date(from: self) else { return 0 }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: string)
        return weekDay
    }
    
    func currentTimeInMiliseconds() -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let date = dateFormatter.date(from: self)
        guard let nowDouble = date?.timeIntervalSince1970 else { return 0 }
        return Int(nowDouble)
    }
    
    func getAnotherCastTime() -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let date = dateFormatter.date(from: self)
        guard let nowDouble = date?.timeIntervalSince1970 else { return 0 }
        return Int(nowDouble)
    }
}

extension Double {
    
    func digits() -> Double {
        let partials = sequence(first: self) {
            let p = $0 / 10
            guard p != 0 else { return nil }
            return p
        }
        let array = partials.reversed().map { $0 }.prefix(4)
        print(array)
        let arr = array[0] * 1000 + array[1] * 100 + array[2] * 10 + array[3]
        return Double(arr)
    }
    
}
