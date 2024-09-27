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
            VStack {
                Text("어빌리티")
                    .padding(.bottom)
                    .foregroundColor(.legendary)
                    .font(.mapleBold(16))
                    PickerView(input: viewModel.input.abilityPickerInput, output: $viewModel.output.abilityPickerOutput)
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
                PickerView(input: viewModel.input.hyperPickerInput, output: $viewModel.output.hyperPickerOutput)
                    .padding(.bottom, 5)
                VStack(alignment: .leading) {
                    ForEach(viewModel.output.hyperStats, id: \.stat_type) { item in
                        if let statIncrease = item.stat_increase {
                            HStack {
                                Text(statIncrease)
                                    .foregroundStyle(Color(hex: 0xcad6db))
                                    .shadow(color: .black, radius: 1, x: 1, y: 1)
                                Spacer()
    //                            HStack(spacing: 0) {
                                    Text("Lv. \(item.stat_level)")
    //                            }
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
    
    struct PickerView: View {
        var input: PassthroughSubject<Int, Never>
        @Binding var output: Int
        
        var body: some View {
            HStack {
                Text("PRESETS")
                ForEach(1..<4) { num in
                    Button(action: {
                        input.send(num)
                    }, label: {
                        Text("\(num)")
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.white)
                            .background(output == num ? .black : Color.infoBackground)
                            .border(output == num ? .white : .black, width: 1)
                            .font(.mapleBold(16))
                    })
                }
            }
            .padding(5)
            .background(Color(hex: 0x646f7c))
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
    
}

#Preview {
    HyperStatView(viewModel: HyperStatViewModel())
//    ContentView()
}
