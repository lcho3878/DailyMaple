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
    @State private var isModifying = false
    @State private var isError = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    NavigationLink {
                        DailyQuestListView()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                    TextField("직접 입력하기", text: $inputText)
                        .padding(.vertical)
                        .onSubmit {
                            addQuest(inputText: inputText)
                            inputText = ""
                        }
                    Button(action: {
                        addQuest(inputText: inputText)
                        inputText = ""
                    }, label: {
                        Text("추가")
                    })
                }
                
                ScrollView {
                    VStack(alignment: .leading) {
                        StrokeText(text: "수행 가능한 퀘스트", width: 1, color: .red)
                        if dailyQuest.isEmpty {
                            QuestEmptyView(content: "수행 가능한 퀘스트가 없습니다.\n퀘스트를 추가해보세요!")
                        }
                        else if dailyQuest.filter({ $0.isOn && !$0.isComplete }).isEmpty {
                            QuestEmptyView(content: "모든 퀘스트를 완료했습니다.")
                        }
                        else {
                            ForEach(dailyQuest.filter { $0.isOn && !$0.isComplete }, id: \.id) { quest in
                                QuestRowView(quest: quest, isModifying: $isModifying) {
                                    print("삭제 \($0.title)")
                                    $dailyQuest.remove($0)
                                }
                            }
                            .task {
                                dailyQuest.filter {  $0.isOn && !$0.isComplete }.forEach { quest in
                                    if quest.endDate < Date() {
                                        RealmManager.shared.updateDailyQuest(quest)
                                    }
                                }
                            }
                        }
                        
                        StrokeText(text: "완료한 퀘스트", width: 1, color: .black)
                            .padding(.vertical, 5)
                        ForEach(dailyQuest.filter { $0.isOn && $0.isComplete }, id: \.id) { quest in
                            QuestRowView(quest: quest, isModifying: $isModifying) {
                                print("삭제 \($0.title)")
                                $dailyQuest.remove($0)
                            }
                        }
                        .task {
                            dailyQuest.filter { $0.isOn && $0.isComplete }.forEach { quest in
                                if quest.endDate < Date() {
                                    RealmManager.shared.updateDailyQuest(quest)
                                }
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
        .alert("안내", isPresented: $isError) {
            Button(role: .cancel) {} label: {
                Text("확인")
            }

        } message: {
            Text("이미 동일한 이름의 퀘스트가 존재합니다.")
        }
        .onAppear(perform: {
            RealmManager.shared.printRealmURL()
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
                Image(systemName: quest.isComplete ? "checkmark.circle.fill" : "arrowshape.right.fill" )
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

extension DailyQuestView {
    private func addQuest(inputText: String) {
        guard !inputText.isEmpty else { return }
        let quest = DailyQuest(title: inputText)
        guard dailyQuest.filter({ $0.title == inputText }).isEmpty else {
            isError.toggle()
            return
        }
        $dailyQuest.append(quest)
    }
}

#Preview {
    DailyQuestView()
}


