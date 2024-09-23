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
            Text("하이퍼스탯")
                .padding(.bottom)
                .font(.mapleBold16)
            HyperPickerView(input: viewModel.input, output: $viewModel.output)
                .padding(.bottom, 5)
            VStack(alignment: .leading) {
                ForEach(viewModel.output.hyperStats, id: \.stat_type) { item in
                    if let statIncrease = item.stat_increase {
                        HStack {
                            Text("Lv.\(item.stat_level)")
                            Text(statIncrease)
                        }
                        .font(.mapleLight14)
                        .padding(.bottom, 5)
                        
                    }
                }
            }
            .padding(.top, 10)
        }
//        .font(.mapleBold16)
    }
    
    struct HyperPickerView: View {
        var input: HyperStatViewModel.Input
        @Binding var output: HyperStatViewModel.Output
        
        var body: some View {
            HStack {
                ForEach(1..<4) { num in
                    Button(action: {
                        input.pickerInput.send(num)
                    }, label: {
                        Text("프리셋 \(num)")
                            .foregroundStyle(Color(uiColor: output.pickerOutput == num ? .systemBackground : .label))
                            .background(Color(uiColor: output.pickerOutput == num ? .label : .systemBackground))
                            .font(.mapleBold16)
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
