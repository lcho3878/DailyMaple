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
    
    @State private var inputText = ""
    @State private var fixedText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    NavigationLink {
                        DailyQuestListView(selectedText: $fixedText)
                    } label: {
                        Image(systemName: "plus")
                            .background(.red)
                        //                        EmptyView()
                    }
                    TextField("일일퀘스트 입력", text: $inputText)
                        .onSubmit {
                            guard !inputText.isEmpty else { return }
                            let quest = DailyQuest(title: inputText, endDate: Date().nextDay(), isComplete: false)
                            $dailyQuest.append(quest)
                            inputText = ""
                        }
                }
                ForEach(dailyQuest, id: \.id) { quest in
                    QuestRowView(quest: quest)
                }
            }
            .padding()
        }
        .onChange(of: fixedText, perform: { value in
            guard !value.isEmpty else { return }
            let quest = DailyQuest(title: value, endDate: Date().nextDay(), isComplete: false)
            $dailyQuest.append(quest)
            fixedText = ""
        })
        
        .font(.mapleLight16)
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


