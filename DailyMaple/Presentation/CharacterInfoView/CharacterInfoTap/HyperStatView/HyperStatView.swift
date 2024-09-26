//
//  HyperStatView.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/23/24.
//

import SwiftUI
import Combine

struct HyperStatView: View {
    @StateObject var viewModel: HyperStatViewModel
    
    var body: some View {
        ScrollView {
            Text("어빌리티")
                .padding(.bottom)
                .font(.mapleBold(16))
            HyperPickerView(input: viewModel.input.abilityPickerInput, output: $viewModel.output.abilityPickerOutput)
            VStack {
                Text(viewModel.output.ability.ability_preset_grade)
                    .padding(.bottom, 5)
                VStack(alignment: .leading) {
                    ForEach(viewModel.output.ability.ability_info, id: \.ability_no) { ability in
                        Text(ability.ability_value)
                            .foregroundStyle(ability.abilityColor)
                            
                            .padding(.top, 5)
                    }
                }
            }
            .padding(.vertical, 10)
            .font(.mapleLight(16))
            
            Text("하이퍼스탯")
                .padding(.vertical)
                .font(.mapleBold(16))
            HyperPickerView(input: viewModel.input.hyperPickerInput, output: $viewModel.output.hyperPickerOutput)
                .padding(.bottom, 5)
            VStack(alignment: .leading) {
                ForEach(viewModel.output.hyperStats, id: \.stat_type) { item in
                    if let statIncrease = item.stat_increase {
                        HStack {
                            Text("Lv.\(item.stat_level)")
                            Text(statIncrease)
                        }
                        .font(.mapleLight(14))
                        .padding(.bottom, 5)
                        
                    }
                }
            }
            .padding(.vertical, 10)
        }
    }
    
    struct HyperPickerView: View {
//        var input: HyperStatViewModel.Input
        var input: PassthroughSubject<Int, Never>
        @Binding var output: Int
        
        var body: some View {
            HStack {
                ForEach(1..<4) { num in
                    Button(action: {
                        input.send(num)
                    }, label: {
                        Text("프리셋 \(num)")
                            .foregroundStyle(Color(uiColor: output == num ? .systemBackground : .label))
                            .background(Color(uiColor: output == num ? .label : .systemBackground))
                            .font(.mapleBold(16))
                    })
                }
            }
        }
    }
}

#Preview {
    HyperStatView(viewModel: HyperStatViewModel())
//    ContentView()
}
