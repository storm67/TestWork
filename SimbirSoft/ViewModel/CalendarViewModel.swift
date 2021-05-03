//
//  CalendarViewModel.swift
//  SimbirSoft
//
//  Created by Storm67 on 29/04/2021.
//  Copyright © 2021 Storm67. All rights reserved.
//

import Foundation

final class CalendarViewModel {
    var indexPath: IndexPath?
    var calendarModel: CalendarModel?
    var tableViewTaskModel = [TableViewTaskModel]()
    fileprivate let dateManager: DateManager
    fileprivate let realmManager: RealmManager
    init(dateManager: DateManager, realmManager: RealmManager) {
        self.realmManager = realmManager
        self.dateManager = dateManager
    }
    
    func addDates(complete: @escaping () -> Void) {
//        realmManager.delete()
        dateManager.range { [weak self] in
            self?.calendarModel = $0
            complete()
        }
    }
    
    func cellViewModel(index: Int) -> TableViewTaskModel? {
        return tableViewTaskModel[index]
    }
    
    func addValues() {
        for i in 0..<24 {
            tableViewTaskModel.append(TableViewTaskModel(hours: i, name: nil, description: nil, start: nil, end: nil))
        }
    }
    
    func addTaskToTableView(day: Int, checker: (Double,Double), completion: @escaping () -> Void) {
        addValues()
        DispatchQueue.global().async {
            self.realmManager.read { (value) in
                guard let collection = value as? [String:String] else { return }
                for i in 0...collection.count {
                    print(i)
                    if let start = collection["start"] {
                        if let end = collection["end"] {
                            guard let start = Double(start), let end = Double(end) else { return }
                            let range = self.dateManager.getMainDateFromSince1970(start: start, end: end)
                            print((start...end),checker,"zxczxc")
                            if (start...end).contains(checker.0) || (start...end).contains(checker.1) {
                                if range.contains(day) {
                                    guard let last = range.last else { return }
                                    //print(last.distance(to: day),last,day,"oooo")
                                    let distance = last.distance(to: day)
                                    if distance >= 2 || distance <= -2 {
                                        if self.dateManager.getDay(from: start) == day {
                                            let correctRange = self.dateManager.getHoursRange(from: start, to: end)
                                            guard let firstRange = correctRange.first else { return }
                                            for i in firstRange..<24 {
                                            self.tableViewTaskModel[i].name = collection["name"]
                                            completion()
                                            }
                                        } else {
                                        for i in 0..<24 {
                                            self.tableViewTaskModel[i].name = collection["name"]
                                            completion()
                                            }
                                        }
                                    }
                                    if last.distance(to: day) == -1 {
                                        let startDay = self.dateManager.getDay(from: start)
                                        let endDay = self.dateManager.getDay(from: end)
                                        //print(startDay,endDay,"aaaa")
                                        if startDay.distance(to: endDay) > 1 || startDay.distance(to: endDay) < 1 {
                                            //print(self.dateManager.getHoursRange(from: start, to: end))
                                            for i in 0..<24 {
                                                self.tableViewTaskModel[i].name = collection["name"]
                                                completion()
                                            }
                                        } else {
                                            guard let firstCorrectHours = self.dateManager.getAnotherHoursRangeCorrect(from: start, to: end).first else { return }
                                            print(self.dateManager.getAnotherHoursRangeCorrect(from: start, to: end))
                                            for i in firstCorrectHours..<24 {
                                                self.tableViewTaskModel[i].name = collection["name"]
                                                completion()
                                            }
                                        }
                                    }
                                    if last.distance(to: day) == 0 {
                                        let completeHours = self.dateManager.getHoursRangeCorrect(from: start, to: end)
                                        //print(completeHours,"rrr")
                                        completeHours.forEach {
                                            self.tableViewTaskModel[$0].name = collection["name"]
                                            completion()
                                        }
                                    }
                                    if last.distance(to: day) == 1 {
                                        let completeHours = self.dateManager.getHoursRange(from: start, to: end)
                                        completeHours.forEach {
                                            self.tableViewTaskModel[$0].name = collection["name"]
                                            completion()
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func cellViewModelCalendar(index: Int) -> Int? {
        return calendarModel?.days?[index]
    }
    
    func switchYear(int: Int) -> Bool {
        if int > 11 {
            calendarModel?.current = 0
            calendarModel?.year += 1
            return true
        }
        if int < 0 {
            calendarModel?.current = 11
            calendarModel?.year -= 1
            return true
        }
        return false
    }
    
    func switchMonth(tag: Int, complete: @escaping () -> Void) {
        guard let calendar = calendarModel else { return }
        switch tag {
        case 0:
            calendarModel?.days = dateManager.daysReplace(for: calendar.current + 1, year: calendar.year)
        case 1:
            calendarModel?.days = dateManager.daysReplace(for: calendar.current - 1, year: calendar.current)
        default: break
        }
        complete()
    }
    
    func indent(year: Int, month: Int, day: Int) {
        let indent: Int
        var count = -1
        var array = [Int]()
        array = calendarModel?.days ?? []
        let day = dateManager.getWeekday(year: year, month: month, day: day - 1)
        let first = dateManager.previousMonth(year: year, month: month - 1)
        if day != 1 {
            indent = first - (day - 1)
            stride(from: first, to: indent, by: -1).forEach {
                count += 1
                array.insert($0, at: 0)
                calendarModel?.days = array
            }
        }
        calendarModel?.indent = count
    }
    
}
