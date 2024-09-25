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
    
    let list = [
        "소멸의 여로",
        "츄츄 아일랜드",
        "레헬른",
        "아르카나",
        "모라스",
        "에스페라",
    ]
    var body: some View {
        List(list, id: \.self) { item in
            Text(item)
                .onTapGesture {
                    selectedText = item
                    dismiss()
                }
        }
    }
}
