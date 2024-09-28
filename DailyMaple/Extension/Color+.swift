//
//  Color+.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/27/24.
//

import SwiftUI

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
    
    static let rare = Color(hex: 0x0099c3)
    static let epic = Color(hex: 0x7859bc)
    static let unique = Color(hex: 0xddaf01)
    static let legendary = Color(hex: 0x8ebb0b)
    
    static let infoBackground = Color(hex: 0x323842)
    static let statBackground = Color(hex: 0x86949f)
    static let statTitle = Color(hex: 0xcad6db)
}
