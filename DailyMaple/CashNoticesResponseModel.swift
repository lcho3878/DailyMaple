//
//  CashNoticesResponseModel.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/27/24.
//

import Foundation

struct CashNoticesResponseModel: Decodable {
    let cashshop_notice: [CashNotice]
    
    struct CashNotice: Decodable {
        let title: String
        let url: String
        let notice_id: Int
        let date: String
        let date_sale_start: String?
        let date_sale_end: String?
        let ongoing_flag: String
    }
}
