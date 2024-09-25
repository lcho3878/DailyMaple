//
//  DailyQuest.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/24/24.
//

import Foundation
import RealmSwift

final class DailyQuest: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var endDate: Date
    @Persisted var isComplete: Bool
    
    convenience init(title: String, endDate: Date , isComplete: Bool) {
        self.init()
        self.title = title
        self.endDate = endDate
        self.isComplete = isComplete
    }
}
