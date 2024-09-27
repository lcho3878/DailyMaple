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
                    VStack(spacing: 5) {
                        PowerView(power: stats.statValue(name: "전투력"))
//                        Text("스탯 공격력 \(stats.statValue(name: "최소 스탯공격력")) ~ \(stats.statValue(name: "최대 스탯공격력"))")
                    }
                    .font(.mapleBold(20))
                    let columns = [
                        GridItem(.flexible(minimum: 50, maximum: .infinity)),
                        GridItem(.flexible(minimum: 50, maximum: .infinity)),
                       
                    ]
                    LazyVGrid(columns: columns) {
                        ForEach(Stat.MainStat.allCases, id: \.self) { item in
                            MainStatView(name: item.rawValue, value: stats.statValue(name: item.rawValue))
                        }
                        .padding()
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: 0x8694a0))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    VStack {
                        StatRowView(data: Stat.DamageStat.allCases, stats: stats)
                        StatRowView(data: Stat.SubStat.allCases, stats: stats)
                        
                        StatRowView(data: Stat.CoolTimeStat.allCases, stats: stats)
                        StatRowView(data: Stat.AttributeStat.allCases, stats: stats)
                        StatRowView(data: Stat.ForceStat.allCases, stats: stats)
                        StatRowView(data: Stat.OtherStat.allCases, stats: stats)
                    }
                    .background(Color(hex: 0x6c7885))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .background(Color(hex: 0x28323b))
                .font(.mapleBold(16))
            }
        }
    }
    
    struct PowerView: View {
        let power: String
        var body: some View {
            ZStack(alignment: .center) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(hex: 0x3f6076))
                    .frame(height: 50)
                    HStack {
                        Text("전투력")
                            .foregroundStyle(Color(hex: 0xd4eef2))
                        Spacer()
                        Text(power)
                            .foregroundStyle(Color(hex: 0xfffad2))
                        Spacer()
                        Spacer()
                    }
                    .padding()
            }
        }
    }
    
    struct MainStatView: View {
        let name: String
        let value: String
        var body: some View {
            HStack{
                Text(name)
                    .foregroundStyle(Color(hex: 0xdce5ec))
                    .shadow(color: .black, radius: 1, x: 1, y: 1)
                Spacer()
                Text(value)
                    .foregroundStyle(Color(hex: 0xe5eef4))
            }
        }
    }
    
    struct StatRowView<T> : View where T: RawRepresentable, T: CaseIterable, T.RawValue == String, T: StatProtocol {
        let data: [T]
        let stats: CharacterStatResponseModel
        var body: some View {
            ForEach(data, id: \.rawValue) { item in
                HStack {
                    Text(item.rawValue)
                        .foregroundStyle(Color(hex: 0xcad6db))
                        .shadow(color: .black, radius: 1, x: 1, y: 1)
                    Spacer()
                    HStack(spacing: 0) {
                        Text(stats.statValue(name: item.rawValue))
                        if let tailString = item.tailString {
                            Text(tailString)
                        }
                    }
                    .foregroundColor(.white)
                }
            }
            .padding()
        }
    }
}

#Preview {
    CharacterStatView(viewModel: CharacterStatViewModel())
//    ContentView()
}
