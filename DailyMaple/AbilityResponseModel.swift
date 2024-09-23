//
//  AbilityResponseModel.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/23/24.
//

import Foundation

struct AbilityResponseModel: Decodable {
    let ability_grade: String
    let remain_fame: Int
    let preset_no: Int
    
    let ability_preset_1: Ability
    let ability_preset_2: Ability
    let ability_preset_3: Ability
    
    struct Ability: Decodable {
        let ability_preset_grade: String
        let ability_info: [AbilityInfo]
        
        struct AbilityInfo: Decodable {
            let ability_no: String
            let ability_grade: String
            let ability_value: String
        }
    }
}
