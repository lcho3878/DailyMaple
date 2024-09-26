//
//  EventsResponseModel.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/26/24.
//

import Foundation

struct EventsResponseModel: Decodable {
    let event_notice: [Event]
    
    struct Event: Decodable {
        let title: String
        let url: String
        let notice_id: Int
        let date: String
        let date_event_start: String
        let date_event_end: String
    }
}
