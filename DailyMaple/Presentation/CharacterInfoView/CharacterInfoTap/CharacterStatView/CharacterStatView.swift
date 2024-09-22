//
//  CharacterStatView.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/21/24.
//

import SwiftUI

struct CharacterStatView: View {
    typealias Stat = CharacterStatResponseModel
    @StateObject var viewModel: CharacterStatViewModel
    
    var body: some View {
        ScrollView {
            if let stats = viewModel.output.stats {
                VStack {
                    VStack {
                        Text(stats.statValue(name: "전투력"))
                        Text("스탯 공격력 \(stats.statValue(name: "최소 스탯공격력")) ~ \(stats.statValue(name: "최대 스탯공격력"))")
                    }
                    let rows = [
                        GridItem(.flexible(minimum: 20, maximum: 100)),
                        GridItem(.flexible(minimum: 20, maximum: 100)),
                    ]
                    LazyHGrid(rows: rows) {
                        ForEach(Stat.MainStat.allCases, id: \.self) { item in
                            HStack {
                                Text(item.rawValue)
                                Text(stats.statValue(name: item.rawValue))
                            }
                        }
                        .padding()
                    }
                    VStack {
                        StatRowView(data: Stat.DamageStat.allCases, stats: stats)
                        StatRowView(data: Stat.SubStat.allCases, stats: stats)
                        StatRowView(data: Stat.ForceStat.allCases, stats: stats)
                        StatRowView(data: Stat.CoolTimeStat.allCases, stats: stats)
                        StatRowView(data: Stat.AttributeStat.allCases, stats: stats)
                        StatRowView(data: Stat.OtherStat.allCases, stats: stats)
                    }
                }
                .font(.mapleBold16)
            }
        }
    }
    
    struct StatRowView<T> : View where T: RawRepresentable, T: CaseIterable, T.RawValue == String {
        let data: [T]
        let stats: CharacterStatResponseModel
        var body: some View {
            ForEach(data, id: \.rawValue) { item in
                HStack {
                    Text(item.rawValue)
                    Spacer()
                    Text(stats.statValue(name: item.rawValue))
                }
            }
            .padding()
        }
    }
}

#Preview {
    CharacterStatView(viewModel: CharacterStatViewModel())
}
