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
            ListView(data: MonsterPark.allCases) { item in
                addItem(item.rawValue)
            }
            ListView(data: ArcaneRegion.allCases) { item in
                addItem(item.rawValue)
            }
            ListView(data: TenebrisRegion.allCases) { item in
                addItem(item.rawValue)
            }
            ListView(data: AuthenticRegion.allCases) { item in
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
    
    private enum MonsterPark: String, CaseIterable, QuestHeader {
        case monsterPark = "몬스터 파크"
        case extremeMonsterPark = "익스트림 몬스터 파크"
        
        static var header = "아케인 리버"
        var isOn: Bool {
            guard let object = RealmManager.shared.getObject(WeeklyQuest.self, key: self.rawValue) else { return false }
            return object.isOn
        }
    }
    
    private enum ArcaneRegion: String, CaseIterable, QuestHeader {
        case vanishingJourney = "소멸의 여로"
        case chuChuIsland = "츄츄 아일랜드"
        case lachelein = "레헬른"
        case arcana = "아르카나"
        case morass = "모라스"
        case esfera = "에스페라"
        
        static var header = "아케인 리버"
        var isOn: Bool {
            guard let object = RealmManager.shared.getObject(WeeklyQuest.self, key: self.rawValue) else { return false }
            return object.isOn
        }
    }
    
    private enum TenebrisRegion: String, CaseIterable, QuestHeader {
        case moonbridge = "문브릿지"
        case labyrinthOfSuffering = "고통의 미궁"
        case limen = "리멘"
        
        static var header = "테네브리스"
        var isOn: Bool {
            guard let object = RealmManager.shared.getObject(WeeklyQuest.self, key: self.rawValue) else { return false }
            return object.isOn
        }
    }
    
    private enum AuthenticRegion: String, CaseIterable, QuestHeader {
        case cernium = "세르니움"
        case arcs = "아르크스"
        case odium = "오디움"
        case shangriLa = "도원경"
        case arteria = "아르테리아"
        case karcion = "카르시온"
        
        static var header = "그란디스 대륙"
        var isOn: Bool {
            guard let object = RealmManager.shared.getObject(WeeklyQuest.self, key: self.rawValue) else { return false }
            return object.isOn
        }
    }
    
}

#Preview {
    WeeklyQuestListView()
}
