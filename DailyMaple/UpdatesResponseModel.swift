//
//  UpdatesResponseModel.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/27/24.
//

import Foundation

struct UpdatesResponseModel: Decodable {
    let update_notice: [Update]
    
    struct Update: Decodable {
        let title: String
        let url: String
        let notice_id: Int
        let date: String
    }
}
