//
//  RealmManager.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/28/24.
//

import Foundation
import RealmSwift

final class RealmManager {
    private let realm = try! Realm()
    
    static let shared = RealmManager()
    
    private init() {}
    
    func printRealmURL() {
        print(realm.configuration.fileURL!)
    }
    
    func getObject<T: Object>(_ type: T.Type, key: String) -> T? {
        return realm.object(ofType: T.self, forPrimaryKey: key)
    }
    
    func updateObject<T>(_ type: T.Type, key: String) where T: Object, T: QuestObject {
        guard let object = getObject(T.self, key: key) else {
            let quest = T(title: key)
            try! realm.write {
                realm.add(quest)
            }
            return
        }
        try! realm.write {
            realm.delete(object)
        }
    }
    
    func updateDailyQuest(_ quest: DailyQuest) {
        try! realm.write {
            quest.thaw()?.endDate = Date().nextDay()
            quest.thaw()?.isComplete = false
        }
    }
}
