//
//  EventsResponseModel.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/26/24.
//

import Foundation

struct EventsResponseModel: Decodable {
    let event_notice: [Event]
    
    struct Event: Decodable, Eventable {
        let title: String
        let url: String
        let notice_id: Int
        let date: String
        let date_event_start: String
        let date_event_end: String
        
        var mobileURL: String {
            return url.replacingOccurrences(of: "https://", with: "https://m.")
        }
        
        var startDate: String {
            return date_event_start.toDateString(format: "y-M-d(E)")
        }
        
        var endDate: String? {
            return date_event_end.toDateString(format: "y-M-d(E)")
        }
    }
}
