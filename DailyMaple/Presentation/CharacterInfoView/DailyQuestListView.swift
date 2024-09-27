//
//  DailyQuestListView.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/25/24.
//

import SwiftUI

struct DailyQuestListView: View {
    @Binding var selectedText: String
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        List {
            ListView(selectedText: $selectedText, data: ArcaneRegion.allCases) {
                dismiss()
            }
            ListView(selectedText: $selectedText, data: TenebrisRegion.allCases) {
                dismiss()
            }
            ListView(selectedText: $selectedText, data: AuthenticRegion.allCases) {
                dismiss()
            }
        }
    }
    
    struct ListView<T>: View where T: RawRepresentable, T: CaseIterable, T.RawValue == String, T: QuestHeader {
        @Binding var selectedText: String
        let data : [T]
        let handler: () -> Void
        var body: some View {
            Section {
                ForEach(data, id: \.rawValue) { item in
                    HStack {
                        Text(item.rawValue)
                        Spacer()
                    }
                    .contentShape(.rect)
                    .onTapGesture {
                        selectedText = item.rawValue
                        handler()
                    }
                }
            } header: {
                Text(T.header)
            }
        }
    }
}

extension DailyQuestListView {
    
    private enum ArcaneRegion: String, CaseIterable, QuestHeader {
        case vanishingJourney = "소멸의 여로"
        case chuChuIsland = "츄츄 아일랜드"
        case lachelein = "레헬른"
        case arcana = "아르카나"
        case morass = "모라스"
        case esfera = "에스페라"
        
        static var header = "아케인 리버"
    }
    
    private enum TenebrisRegion: String, CaseIterable, QuestHeader {
        case moonbridge = "문브릿지"
        case labyrinthOfSuffering = "고통의 미궁"
        case limen = "리멘"
        
        static var header = "테네브리스"
    }
    
    private enum AuthenticRegion: String, CaseIterable, QuestHeader {
        case cernium = "세르니움"
        case arcs = "아르크스"
        case odium = "오디움"
        case shangriLa = "도원경"
        case arteria = "아르테리아"
        case karcion = "카르시온"
        
        static var header = "그란디스 대륙"
    }
    
}

#Preview {
    DailyQuestView()
    //    ContentView()
}
