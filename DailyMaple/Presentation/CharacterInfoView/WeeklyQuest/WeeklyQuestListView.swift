//
//  WeeklyQuestListView.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/30/24.
//

import SwiftUI
import RealmSwift

struct WeeklyQuestListView: View {
    @ObservedResults(WeeklyQuest.self)
    var dailyQuest
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        List {
            ListView(data: EpicDungeon.allCases) { item in
                addItem(item.rawValue)
            }
            ListView(data: ArcaneRegion.allCases) { item in
                addItem(item.rawValue)
            }
            ListView(data: GuildContent.allCases) { item in
                addItem(item.rawValue)
            }
            ListView(data: WeeklyContent.allCases) { item in
                addItem(item.rawValue)
            }
        }
        .listStyle(.grouped)
    }
    
    struct ListView<T>: View where T: RawRepresentable, T: CaseIterable, T.RawValue == String, T: QuestHeader {
        let data : [T]
        let handler: (T) -> Void
        var body: some View {
            Section {
                ForEach(data, id: \.rawValue) { item in
                    Button() {
                        handler(item)
                    } label: {
                        HStack {
                            Text(item.rawValue)
                            Text(item.isOn ? "등록완료" : "등록하기")
                                .foregroundStyle(.white)
                                .background(item.isOn ? .blue : .gray)
                        }
                    }
                    .foregroundColor(.black)
                }
            } header: {
                Text(T.header)
            }
        }
    }
    
    private func addItem(_ title: String) {
        RealmManager.shared.updateObject(WeeklyQuest.self, key: title)
    }
}

extension WeeklyQuestListView {
    
    private enum EpicDungeon: String, CaseIterable, QuestHeader {
        case anlgerCompany = "에픽던전 : 앵글러 컴퍼니"
        case hignMountain = "에픽던전 : 하이마운틴"
        
        static var header = "에픽던전"
        var isOn: Bool {
            guard let object = RealmManager.shared.getObject(WeeklyQuest.self, key: self.rawValue) else { return false }
            return object.isOn
        }
    }
    
    private enum ArcaneRegion: String, CaseIterable, QuestHeader {
        case erdaSpectrum = "에르다 스펙트럼"
        case mooto = "배고픈 무토"
        case midnightChaser = "미드나잇 체이서"
        case spiritSaver = "스피릿 세이비어"
        case enhimeDefense = "엔하임 디펜스"
        case protectEspera = "프로텍트 에스페라"
        
        static var header = "아케인 리버"
        var isOn: Bool {
            guard let object = RealmManager.shared.getObject(WeeklyQuest.self, key: self.rawValue) else { return false }
            return object.isOn
        }
    }
    
    private enum GuildContent: String, CaseIterable, QuestHeader {
        case weeklyMission = "주간 미션"
        case underwater = "지하 수로"
        case flagRace = "플래그 레이스"
        
        static var header = "길드 컨텐츠"
        var isOn: Bool {
            guard let object = RealmManager.shared.getObject(WeeklyQuest.self, key: self.rawValue) else { return false }
            return object.isOn
        }
    }
    
    private enum WeeklyContent: String, CaseIterable, QuestHeader {
        case diligentInvestigation = "[소멸의 여로] 성실한 조사에 대한 보답"
        case critias = "크리티아스"
        case corruptedWorldTree = "타락한 세계수"
        case heaven = "헤이븐"
        
        
        static var header = "주간 퀘스트"
        var isOn: Bool {
            guard let object = RealmManager.shared.getObject(WeeklyQuest.self, key: self.rawValue) else { return false }
            return object.isOn
        }
    }
    
}

#Preview {
    WeeklyQuestListView()
}
