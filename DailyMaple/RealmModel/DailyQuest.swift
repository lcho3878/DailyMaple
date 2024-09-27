//
//  DailyQuest.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/24/24.
//

import Foundation
import RealmSwift

final class DailyQuest: Object, ObjectKeyIdentifiable, QuestObject {
    @Persisted(primaryKey: true) var title: String
    @Persisted var endDate: Date
    @Persisted var isComplete: Bool
    @Persisted var isOn: Bool
    
    convenience init(title: String) {
        self.init()
        self.title = title
        self.endDate = Date().nextDay()
        self.isComplete = false
        self.isOn = true
    }
}
