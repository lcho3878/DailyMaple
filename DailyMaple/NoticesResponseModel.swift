//
//  NoticesResponseModel.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/27/24.
//

import Foundation

struct NoticesResponseModel: Decodable {
    let notice: [Notice]
    
    struct Notice: Decodable, Eventable {
        let title: String
        let url: String
        let notice_id: Int
        let date: String
        
        var mobileURL: String {
            return url.replacingOccurrences(of: "https://", with: "https://m.")
        }
        
        var startDate: String {
            return date.toDateString(format: "y-M-d(E)")
        }
        
        var endDate: String? {
            return nil
        }
    }
}
