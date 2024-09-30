//
//  WeeklyQuest.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/30/24.
//

import Foundation
import RealmSwift

final class WeeklyQuest: Object, ObjectKeyIdentifiable, QuestObject {
    @Persisted(primaryKey: true) var title: String
    @Persisted var endDate: Date
    @Persisted var isComplete: Bool
    @Persisted var isOn: Bool
    
    convenience init(title: String) {
        self.init()
        self.title = title
        self.endDate = Date().nextMonday()
        self.isComplete = false
        self.isOn = true
    }
}
