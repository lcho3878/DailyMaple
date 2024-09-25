//
//  Date+.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/25/24.
//

import Foundation

extension Date {
    static let formatter = DateFormatter()
    
    //다음날 자정인지 확인 필요
    public func nextDay() -> Date {
        let calender = Calendar.current
        return calender.date(bySetting: .hour, value: 0, of: Date()) ?? Date()
    }
    
    public func nextThursDay() -> Date {
        let calender = Calendar.current
        return calender.date(bySetting: .weekday, value: 5, of: Date()) ?? Date()
    }
    
    public func asString() -> String {
        let format = "M월 d일 KK시 mm분 ss초, a"
        Date.formatter.dateFormat = format
        return Date.formatter.string(from: self)
    }
}
