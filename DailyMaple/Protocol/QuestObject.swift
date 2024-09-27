//
//  QuestObject.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/28/24.
//

import Foundation

protocol QuestObject {
    var endDate: Date { get }
    var isComplete: Bool { get }
    var isOn: Bool { get }
    init(title: String)
}
