//
//  EquipmentsResponseModel.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/22/24.
//

import Foundation
import SwiftUI

struct EquipmentsResponseModel: Decodable {
    let item_equipment: [Item]
    
    struct Item: Decodable, Identifiable {
        let id = UUID()
        let item_equipment_part: String
        let item_equipment_slot: String
        let item_name: String
        let item_icon: String
        let item_shape_name: String
        let item_shape_icon: String
       
        let potential_option_grade: String?
        let additional_potential_option_grade: String?
        func potentialFirstChar(grade: String) -> String {
            switch grade {
            case "레어": return "R"
            case "에픽": return "E"
            case "유니크": return "U"
            case "레전드리": return "L"
            default: return ""
            }
        }
        
        var potentialColor: Color {
            switch potential_option_grade {
            case "레어": return .blue
            case "에픽": return .purple
            case "유니크": return .yellow
            case "레전드리": return .green
            default: return .clear
            }
        }
        var additionalColor: Color {
            switch additional_potential_option_grade {
            case "레어": return .blue
            case "에픽": return .purple
            case "유니크": return .yellow
            case "레전드리": return .green
            default: return .clear
            }
        }
        let potential_option_1: String?
        let potential_option_2: String?
        let potential_option_3: String?
        let additional_potential_option_1: String?
        let additional_potential_option_2: String?
        let additional_potential_option_3: String?
        let starforce: String
        var starforceLevel: Int? {
            let equips = ["반지2", "펜던트", "무기", "벨트", "얼굴장식", "눈장식", "모자", "상의", "하의", "신발", "어깨장식", "망토", "장갑", "귀고리", "기계 심장"]
            guard equips.contains(item_equipment_slot) else { return nil }
            return Int(starforce)
        }
        var maxStarForce: Int? {
            let equips = ["반지2", "펜던트", "무기", "벨트", "얼굴장식", "눈장식", "모자", "상의", "하의", "신발", "어깨장식", "망토", "장갑", "귀고리", "기계 심장"]
            guard equips.contains(item_equipment_slot) else { return nil }
            switch item_base_option.base_equipment_level {
            case 95...107: return 8
            case 108...117: return 10
            case 118...127: return 15
            case 128...137: return 20
            case 138...: return 25
            default: return 5
            }
        }
        let scroll_upgrade: String
        var scrollUpgrade: String {
            guard scroll_upgrade != "0" else { return "" }
            return "(+\(scroll_upgrade))"
        }

        struct TotalOptions: Decodable, PropertyReflectable {
            let str: String
            let dex: String
            let int: String
            let luk: String
            let max_hp: String
            let max_mp: String
            let attack_power: String
            let magic_power: String
            let armor: String
            let speed: String
            let jump: String
            let boss_damage: String
            let ignore_monster_armor: String
            let all_stat: String
            let damage: String // Total
            let equipment_level_decrease: Int
            let max_hp_rate: String
            let max_mp_rate: String
        }
        
        struct BaseOptions: Decodable, PropertyReflectable {
            let str: String
            let dex: String
            let int: String
            let luk: String
            let max_hp: String
            let max_mp: String
            let attack_power: String
            let magic_power: String
            let armor: String
            let speed: String
            let jump: String
            let boss_damage: String
            let ignore_monster_armor: String
            let all_stat: String
            let max_hp_rate: String
            let max_mp_rate: String
            let base_equipment_level: Int // Base
        }
        
        struct AddOptions: Decodable, PropertyReflectable {
            let str: String
            let dex: String
            let int: String
            let luk: String
            let max_hp: String
            let max_mp: String
            let attack_power: String
            let magic_power: String
            let armor: String
            let speed: String
            let jump: String
            let boss_damage: String
            let damage: String
            let all_stat: String
            let equipment_level_decrease: Int
        }
        
        struct EtcOptions: Decodable, PropertyReflectable {
            let str: String
            let dex: String
            let int: String
            let luk: String
            let max_hp: String
            let max_mp: String
            let attack_power: String
            let magic_power: String
            let armor: String
            let speed: String
            let jump: String
        }
        
        struct StarForceOptions: Decodable, PropertyReflectable {
            let str: String
            let dex: String
            let int: String
            let luk: String
            let max_hp: String
            let max_mp: String
            let attack_power: String
            let magic_power: String
            let armor: String
            let speed: String
            let jump: String
        }
        
        let item_total_option: TotalOptions
        let item_base_option: BaseOptions
        let item_add_option: AddOptions
        let item_etc_option: EtcOptions
        let item_starforce_option: StarForceOptions
    }
}
