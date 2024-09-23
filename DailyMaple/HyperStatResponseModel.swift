//
//  HyperStatResponseModel.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/23/24.
//

import Foundation

struct HyperStatResponseModel: Decodable {
    let use_preset_no: String
    let use_available_hyper_stat: Int
    let hyper_stat_preset_1: [HyperStat]
    let hyper_stat_preset_2: [HyperStat]
    let hyper_stat_preset_3: [HyperStat]
    
    struct HyperStat: Decodable {
        let stat_type: String
        let stat_point: Int?
        let stat_level: Int
        let stat_increase: String?
    }
    
    let hyper_stat_preset_1_remain_point: Int
    let hyper_stat_preset_2_remain_point: Int
    let hyper_stat_preset_3_remain_point: Int
}
