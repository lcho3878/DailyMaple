//
//  HyperStatView.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/23/24.
//

import SwiftUI

struct HyperStatView: View {
    @StateObject var viewModel: HyperStatViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                Text("어빌리티")
                    .padding(.bottom)
                    .foregroundColor(.legendary)
                    .font(.mapleBold(16))
                    PresetPickerView(input: viewModel.input.abilityPickerInput, output: $viewModel.output.abilityPickerOutput)
                    AbilityContentView(viewModel: viewModel)
                
            }
            .padding(.vertical)
            .background(Color.statBackground)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .padding(.vertical)
            
            HyperStatContentView(viewModel: viewModel)
        }
        .background(Color.infoBackground)
    }
    
    struct AbilityContentView: View {
        @StateObject var viewModel: HyperStatViewModel
        var body: some View {
            VStack {
                HStack {
                    Image(systemName: "bookmark.fill")
                    Text("\(viewModel.output.ability.ability_preset_grade) 어빌리티")
                }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .foregroundStyle(.white)
                    .background(viewModel.output.ability.abilityColor)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.horizontal)
                VStack(alignment: .leading) {
                    ForEach(viewModel.output.ability.ability_info, id: \.ability_no) { ability in
                        Text(ability.ability_value)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .foregroundStyle(.white)
                            .background(ability.abilityColor)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .padding(.horizontal)
                    }
                }
                .padding(.vertical)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.horizontal)
            }
            
            .font(.mapleLight(16))
        }
    }
    
    struct HyperStatContentView: View {
        @StateObject var viewModel: HyperStatViewModel
        var body: some View {
            VStack {
                Text("하이퍼스텟")
                    .padding(.bottom)
                    .foregroundColor(.legendary)
                    .font(.mapleBold(16))
                PresetPickerView(input: viewModel.input.hyperPickerInput, output: $viewModel.output.hyperPickerOutput)
                    .padding(.bottom, 5)
                VStack(alignment: .leading) {
                    ForEach(viewModel.output.hyperStats, id: \.stat_type) { item in
                        if let statIncrease = item.stat_increase {
                            HStack {
                                Text(statIncrease)
                                    .foregroundStyle(Color(hex: 0xcad6db))
                                    .shadow(color: .black, radius: 1, x: 1, y: 1)
                                Spacer()
                                    Text("Lv. \(item.stat_level)")
                                .foregroundColor(.white)
                            }
                            .font(.mapleBold(16))
                            .padding()
                        }
                    }
                }
                .padding(.vertical, 10)
            }
            .padding(.vertical)
            .background(Color.statBackground)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}

#Preview {
    HyperStatView(viewModel: HyperStatViewModel())
//    ContentView()
}
