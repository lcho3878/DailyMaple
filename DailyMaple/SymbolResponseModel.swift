//
//  SymbolResponseModel.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/22/24.
//

import Foundation

struct SymbolResponseModel: Decodable {
    let symbol: [Symbol]
    
    struct Symbol: Decodable {
        let symbol_name: String
        let symbol_icon: String
        let symbol_description: String
        let symbol_force: String
        let symbol_level: Int
        let symbol_str: String
        let symbol_dex: String
        let symbol_int: String
        let symbol_luk: String
        let symbol_hp: String
        let symbol_growth_count: Int
        let symbol_require_growth_count: Int
        
        var symbolRegion: String {
            return symbol_name.components(separatedBy: " : ")[0]
        }
        
        var symbolCity: String {
            return symbol_name.components(separatedBy: " : ")[1]
        }
    }
}
