//
//  NoticesResponseModel.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/27/24.
//

import Foundation

struct NoticesResponseModel: Decodable {
    let notice: [Notice]
    
    struct Notice: Decodable {
        let title: String
        let url: String
        let notice_id: Int
        let date: String
    }
}
