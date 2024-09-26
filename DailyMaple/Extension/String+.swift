//
//  String+.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/27/24.
//

import Foundation

extension String {
    static let formatter = DateFormatter()
    
    public func toDateString(format: String) -> String {
        String.formatter.dateFormat = "yyyy-MM-dd'T'HH:mmXXXXX"
        guard let date = String.formatter.date(from: self) else { return "닐인데요ㅕ" }
        return date.asString(format: format)
    }
}
