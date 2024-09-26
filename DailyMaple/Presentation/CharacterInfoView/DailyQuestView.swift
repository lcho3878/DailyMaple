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
    @State private var isModifying = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    NavigationLink {
                        DailyQuestListView(selectedText: $fixedText)
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                    TextField("직접 입력하기", text: $inputText)
                        .padding(.vertical)
                        .onSubmit {
                            guard !inputText.isEmpty else { return }
                            let quest = DailyQuest(title: inputText, endDate: Date().nextDay(), isComplete: false)
                            $dailyQuest.append(quest)
                            inputText = ""
                        }
                    Button(action: {
                        guard !inputText.isEmpty else { return }
                        let quest = DailyQuest(title: inputText, endDate: Date().nextDay(), isComplete: false)
                        $dailyQuest.append(quest)
                        inputText = ""
                    }, label: {
                        Text("추가")
                    })
                }
                
                ScrollView {
                    VStack(alignment: .leading) {
                        StrokeText(text: "수행 가능한 퀘스트", width: 1, color: .red)
                        //                            .foregroundColor(.white)
                        if dailyQuest.isEmpty {
                            QuestEmptyView(content: "수행 가능한 퀘스트가 없습니다.\n퀘스트를 추가해보세요!")
                        }
                        else if dailyQuest.filter({ !$0.isComplete }).isEmpty {
                            QuestEmptyView(content: "모든 퀘스트를 완료했습니다.")
                        }
                        else {
                            ForEach(dailyQuest.filter { !$0.isComplete }, id: \.id) { quest in
                                QuestRowView(quest: quest, isModifying: $isModifying) {
                                    print("삭제 \($0.title)")
                                    $dailyQuest.remove($0)
                                }
                            }
                        }
                        
                        StrokeText(text: "완료한 퀘스트", width: 1, color: .black)
                            .padding(.vertical, 5)
                        ForEach(dailyQuest.filter { $0.isComplete }, id: \.id) { quest in
                            QuestRowView(quest: quest, isModifying: $isModifying) {
                                print("삭제 \($0.title)")
                                $dailyQuest.remove($0)
                            }
                        }
                    }
                }
            }
            .padding()
            .toolbar(content: {
                ToolbarItem {
                    Button(action: {
                        withAnimation {
                            isModifying.toggle()
                        }
                    }, label: {
                        Text(isModifying ? "완료" : "수정하기")
                    })
                }
            })
        }
        .onChange(of: fixedText, perform: { value in
            guard !value.isEmpty else { return }
            let quest = DailyQuest(title: value, endDate: Date().nextDay(), isComplete: false)
            $dailyQuest.append(quest)
            fixedText = ""
        })
        .font(.mapleLight(16))
    }
    
    struct QuestEmptyView: View {
        let content: String
        var body: some View {
            HStack {
                Spacer()
                Text(content)
                Spacer()
            }
            .padding(.vertical)
        }
    }
    
    struct QuestRowView: View {
        @ObservedRealmObject var quest: DailyQuest
        @Binding var isModifying: Bool
        let onDelete: (DailyQuest) -> Void
        var body: some View {
            HStack {
                Image(systemName: quest.isComplete ? "checkmark.circle" : "arrowshape.right.fill" )
                    .foregroundColor(.blue)
                Text("[일간] \(quest.title)")
                    .foregroundStyle(quest.isComplete ? Color(red: 74/255, green: 11/255, blue: 163/255) : .blue)
                    .strikethrough(quest.isComplete, color: .black)
                Spacer()
                if isModifying {
                    Button {
                        onDelete(quest)
                    } label: {
                        Text("삭제하기")
                            .foregroundStyle(.red)
                    }
                }
                else {
                    CompleteButton(isComplete: $quest.isComplete)
                }
            }
            .padding(.vertical, 5)
            .task {
                if quest.endDate < Date() {
                    let realm = try! Realm()
                    try! realm.write({
                        quest.thaw()?.endDate = Date().nextDay()
                        quest.thaw()?.isComplete = false
                    })
                }
            }
        }
        
        struct CompleteButton: View {
            @Binding var isComplete: Bool
            var body: some View {
                Button(action: {
                    withAnimation {
                        isComplete.toggle()
                    }
                }, label: {
                    if !isComplete {
                        StrokeText(text: "완료가능", width: 1, color: .orange)
                    }
                    else {
                        StrokeText(text: "되돌리기", width: 1, color: .gray)
                    }
                })
            }
        }
    }
}

#Preview {
    DailyQuestView()
}


