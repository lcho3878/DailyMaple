//
//  AbilityResponseModel.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/23/24.
//

import Foundation
import SwiftUI

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
            
            var abilityColor: Color {
                switch ability_grade {
                case "레어": .blue
                case "에픽": .purple
                case "유니크": .yellow
                case "레전드리": .green
                default: .black
                }
            }
        }
    }
}
