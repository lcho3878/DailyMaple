//
//  EquipmentDetailView.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/22/24.
//

import SwiftUI

struct EquipmentDetailView: View {
    typealias Item = EquipmentsResponseModel.Item
    
    let item: Item?
    
    var body: some View {
        if let item {
            ZStack {
                VStack {
                    VStack {
                        StarView(item: item)
                            .padding(.bottom)
                        ItemTitleView(item: item)
                            .foregroundStyle(.white)
                        AsyncImage(url: URL(string: item.item_icon)) { result in
                            result.image?
                                .resizable()
                                .scaledToFit()
                        }
                        .frame(width: 100, height: 100)
                        .overlay(Rectangle().stroke(item.potentialColor, lineWidth: 3))
                        .padding()
                        
                    }
                    VStack(alignment: .leading) {
                        ItemOptionView(item: item)
                           .font(.mapleLight16)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black.opacity(0.8))
            .background(ClearBackground())
        }
    }
    
    struct ItemOptionView: View {
        let item: Item
        var body: some View {
            let keys = Mirror(reflecting: item.item_total_option).children.map { $0.label }
            ForEach(keys, id: \.self) { key in
                if let key, let value1 = Int(item.item_total_option[key] as? String ?? "") {
                    HStack {
                        if value1 != 0 {
                            Text("\(koreanTitle(key: key)): +\(value1)\(titleTail(key: key))")
                                .foregroundStyle(.cyan)
                            Text("(")
                        }
                        if let value2 = Int(item.item_base_option[key] as? String ?? ""), value2 != 0 {
                            Text("+\(value2)\(titleTail(key: key))")
                                .foregroundStyle(.white)
                        }
                        if  let value3 = Int(item.item_add_option[key] as? String ?? ""), value3 != 0 {
                            Text("+\(value3)\(titleTail(key: key))")
                                .foregroundStyle(.green)
                        }
                        if let value4 = Int(item.item_etc_option[key] as? String ?? ""), value4 != 0 {
                            Text("+\(value4)\(titleTail(key: key))")
                                .foregroundStyle(.purple)
                        }
                        if let value5 = Int(item.item_starforce_option[key] as? String ?? ""), value5 != 0 {
                            Text("+\(value5)\(titleTail(key: key))")
                                .foregroundStyle(.orange)
                        }
                        if value1 != 0 {
                            Text(")")
                        }
                    }
                }
            }
            .foregroundStyle(.white)
            if let grade = item.potential_option_grade {
                VStack(alignment: .leading) {
                    HStack {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.white)
                            .frame(width: 20, height: 20)
                            .overlay {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(item.potentialColor)
                                    .frame(width: 18, height: 18)
                                    .overlay {
                                        Text(item.potentialFirstChar(grade: grade))
                                            .foregroundStyle(.white)
                                    }
                            }
                        Text("잠재 옵션")
                            .foregroundStyle(item.potentialColor)
                        
                    }
                    VStack(alignment: .leading) {
                        if let option1 = item.potential_option_1 {
                            Text(option1)
                        }
                        if let option2 = item.potential_option_2 {
                            Text(option2)
                        }
                        if let option3 = item.potential_option_3 {
                            Text(option3)
                        }
                    }
                    .foregroundStyle(.white)
                }
                .padding(.top)
                .padding(.bottom)
            }
            if let addtionnal = item.additional_potential_option_grade {
                VStack(alignment: .leading) {
                    HStack {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.white)
                            .frame(width: 20, height: 20)
                            .overlay {
                                RoundedRectangle(cornerRadius: 5)
        //                            .stroke(.white)
                                    .fill(item.additionalColor)
                                    .frame(width: 18, height: 18)
                                    .overlay {
                                        Text(item.potentialFirstChar(grade: addtionnal))
                                            .foregroundStyle(.white)
                                    }
                            }
                        Text("잠재 옵션")
                            .foregroundStyle(item.additionalColor)
                    }
                    VStack(alignment: .leading) {
                        if let option1 = item.additional_potential_option_1 {
                            Text(option1)
                        }
                        if let option2 = item.additional_potential_option_2 {
                            Text(option2)
                        }
                        if let option3 = item.additional_potential_option_3 {
                            Text(option3)
                        }
                    }
                    .foregroundColor(.white)
                }
            }
        }
        func koreanTitle(key: String) -> String {
            switch key {
            case "max_hp": return "최대 HP"
            case "max_mp": return "최대 MP"
            case "attack_power": return "공격력"
            case "magic_power": return "마력"
            case "armor": return "방어력"
            case "speed": return "이동속도"
            case "jump": return "점프력"
            case "boss_damage": return "보스 몬스터 공격시 데미지"
            case "ignore_monster_armor": return "몬스터 방어율 무시"
            case "all_stat": return "올스탯"
            case "damage": return "데미지"
            case "max_hp_rate": return "최대 HP(%)"
            case "max_mp_rate": return "최대 MP(%)"
            default: return key.uppercased()
            }
        }
        
        func titleTail(key: String) -> String {
            switch key {
            case "boss_damage", "ignore_monster_armor", "all_stat", "damage", "max_hp_rate", "max_mp_rate" : return "%"
            default: return ""
            }
        }
    }
    
    struct ItemTitleView: View {
        let item: Item
        var body: some View {
            Text("\(item.item_name) \(item.scrollUpgrade)")
                .font(.mapleBold16)
            HStack {
                Text("(")
                if let grade = item.potential_option_grade {
                    Text("\(grade) 아이템")
                        .foregroundStyle(item.potentialColor)
                    Text(" / ")
                    
                }
                Text("Lv.\(item.item_base_option.base_equipment_level) / \(item.item_equipment_part)")
                Text(")")
            }
            .font(.mapleLight16)
        }
    }
    
    struct StarView: View {
        let item: Item
        var body: some View {
            if let starforceLevel = item.starforceLevel,
               let maxStarForce = item.maxStarForce {
                let row = (1...maxStarForce).map { $0 <= starforceLevel ? true : false }
                if maxStarForce > 15 {
                    StarRowView(row: Array(row[0..<15]))
                    StarRowView(row: Array(row[15...]))
                }
                else {
                    StarRowView(row: row)
                }
                
                
            }
        }
    }
    
    struct StarRowView: View {
        let row: [Bool]
        var body: some View {
            HStack {
                ForEach(Array(row.enumerated()), id: \.offset) { i, isStar in
                    Image(systemName: "star.fill")
                        .foregroundStyle(isStar ? .yellow : .white)
                        .frame(width: 10, height: 10)
                        .padding(EdgeInsets(top: 0, leading: i % 5 == 0 ? 10 : 0, bottom: 0, trailing: 3))
                }
            }
        }
    }
}
