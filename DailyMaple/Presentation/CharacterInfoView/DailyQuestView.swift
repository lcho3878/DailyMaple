//
//  DailyQuestView.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/24/24.
//

import SwiftUI
import RealmSwift

struct DailyQuestView: View {
    @ObservedResults(DailyQuest.self)
    private var dailyQuest
    
    @State private var testText = ""
    
    var body: some View {
        List {
            TextField("일일퀘스트 입력", text: $testText)
                .onSubmit {
                    guard !testText.isEmpty else { return }
                    let quest = DailyQuest(title: testText, endDate: Date().nextDay(), isComplete: false)
                    $dailyQuest.append(quest)
                    testText = ""
                }
            ForEach(dailyQuest, id: \.id) { quest in
                QuestRowView(quest: quest)
            }
        }
    }
    
    struct QuestRowView: View {
        @ObservedRealmObject var quest: DailyQuest
        var body: some View {
            HStack {
                Text(quest.title)
                    .strikethrough(quest.isComplete, color: .black)
                Text(quest.endDate.asString())
                Spacer()
                Toggle("", isOn: $quest.isComplete)
                    .labelsHidden()
            }
            .task {
                if quest.isComplete && quest.endDate < Date() {
                    let realm = try! Realm()
                    try! realm.write({
                        quest.thaw()?.endDate = Date().nextDay()
                        quest.thaw()?.isComplete = false
                    })
                }
            }
        }
    }
}

#Preview {
    DailyQuestView()
}


