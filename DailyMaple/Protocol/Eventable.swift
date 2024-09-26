//
//  Eventable.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/27/24.
//

import Foundation

protocol Eventable {
    var title: String { get }
    var notice_id: Int { get }
    var mobileURL: String { get }
    var startDate: String { get }
    var endDate: String? { get }
}
