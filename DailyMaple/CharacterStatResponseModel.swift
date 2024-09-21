//
//  CharacterStatResponseModel.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/21/24.
//

import Foundation

struct CharacterStatResponseModel: Decodable {
    let final_stat: [Stat]
    
    struct Stat: Decodable {
        let stat_name: String
        let stat_value: String
    }
    
    func statValue(name: String) -> String {
        guard let stat = final_stat.first(where: {$0.stat_name == name }) else { return "정보 없음" }
        return stat.stat_value
    }
    
    enum TitleStat: String, CaseIterable {
        case minStatPower = "최소 스탯공격력"
        case maxStatPower = "최대 스탯공격력"
        case power = "전투력"
    }
    
    enum MainStat: String, CaseIterable {
        case hp = "HP"
        case mp = "MP"
        case str = "STR"
        case dex = "DEX"
        case int = "INT"
        case luk = "LUK"
    }
    
    enum DamageStat: String, CaseIterable {
        case damage = "데미지"
        case finalDamage = "최종 데미지"
        case bossDamage = "보스 몬스터 데미지"
        case normalDamage = "일반 몬스터 데미지"
    }
    
    enum SubStat: String, CaseIterable {
        case power = "공격력"
        case charm = "마력"
        case ignoreERA = "방어율 무시"
        case criticalChance = "크리티컬 확률"
        case criticalDamage = "크리티컬 데미지"
    }
    
    enum ForceStat: String, CaseIterable {
        case starForce = "스타포스"
        case arcaneForce = "아케인포스"
        case authenticForce = "어센틱포스"
    }
    
    enum CoolTimeStat: String, CaseIterable {
        case reduceSecond = "재사용 대기시간 감소 (초)"
        case reducePercent = "재사용 대기시간 감소 (%)"
        case noApply = "재사용 대기시간 미적용"
    }
    
    enum AttributeStat: String, CaseIterable {
        case ignoreAttribute = "속성 내성 무시"
        case additionalDamage = "상태이상 추가 데미지"
        case resistance = "상태이상 내성"
    }
    
    enum OtherStat: String, CaseIterable {
        case exp = "추가 경험치 획득"
        case summon = "소환수 지속시간 증가"
        case weapon = "무기 숙련도"
        case stance = "스탠스"
        case defense = "방어력"
        case buffduration = "버프 지속시간"
        case itemDrop = "아이템 드롭률"
        case mesoDrop = "메소 획득량"
    }
}
