//
//  CharacterResponse.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/21/24.
//

import Foundation

struct CharacterResponse: Decodable {
    let character_name: String
    let world_name: String
    let character_gender: String
    let character_class: String
    let character_class_level: String
    let character_level: Int
    let character_exp: Int
    let character_exp_rate: String
    let character_guild_name: String
    let character_image: String
    let liberation_quest_clear_flag: String
}
