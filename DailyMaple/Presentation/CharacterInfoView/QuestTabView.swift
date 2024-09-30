//
//  QuestTabView.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/30/24.
//

import SwiftUI

struct QuestTabView: View {
    @State private var menu: TapMenu = .daily
    
    var body: some View {
        VStack {
            Picker("", selection: $menu) {
                ForEach(TapMenu.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .padding()
            .colorMultiply(.rare)
            .colorInvert()
            .pickerStyle(.segmented)
            switch menu {
            case .daily:
                DailyQuestView()
            case .weekly:
                WeeklyQuestView()
            }
        }
        .background(Color.infoBackground)
    }
}

extension QuestTabView {
    private enum TapMenu: String, CaseIterable {
        case daily = "일간"
        case weekly = "주간"
    }
}

#Preview {
    QuestTabView()
}
