//
//  Date+.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/25/24.
//

import Foundation

extension Date {
    static let formatter = DateFormatter()

    public func nextDay() -> Date {
        let calender = Calendar.current
        let now = Date()
        guard let tomorrow = calender.date(byAdding: .day, value: 1, to: now) else { return now }
        let components = calender.dateComponents([.year, .month, .day], from: tomorrow)
        guard let nextMidnight = calender.date(from: components) else { return now }
        return nextMidnight
    }
    
    public func nextThursDay() -> Date {
        let calender = Calendar.current
        return calender.date(bySetting: .weekday, value: 5, of: Date()) ?? Date()
    }
    
    public func asString() -> String {
        let format = "M월 d일 KK시 mm분 ss초, a"
        Date.formatter.dateFormat = format
        Date.formatter.locale = Locale(identifier: "ko_KR")
        return Date.formatter.string(from: self)
    }
}
