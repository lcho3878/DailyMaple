//
//  EquipmentView.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/22/24.
//

import SwiftUI
import Combine

struct EquipmentView: View {
    typealias Item = EquipmentsResponseModel.Item
    
    @StateObject var viewModel: EquipmentViewModel
    @State private var selectedItem: Item?
    
    var body: some View {
        ScrollView {
            PresetPickerView(input: viewModel.input.pickerInput, output: $viewModel.output.pickerOutput)
            VStack {
                ForEach(viewModel.output.items, id: \.item_equipment_slot) { item in
                    ItemRowView(item: item)
                        .onTapGesture {
                            viewModel.input.selectedItem = item
                        }
                }
                .sheet(item: $viewModel.input.selectedItem) { item in
                    EquipmentDetailView(item: item)
                }
            }
        }
    }
    
    struct ItemRowView: View {
        let item: Item
        var body: some View {
            HStack() {
                AsyncImage(url: URL(string: item.item_icon)) { result in
                    result.image?
                        .resizable()
                        .scaledToFit()
                }
                .frame(width: 50, height: 50)
                .overlay(Rectangle().stroke(item.potentialColor, lineWidth: 3))
                .padding()
                VStack(alignment: .leading) {
                    if item.starforce != "0" {
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundStyle(.yellow)
                            Text(item.starforce)
                        }
                    }
                    Text(item.item_name)
                    Text(item.potential_option_grade ?? "")
                        .foregroundStyle(item.potentialColor)
                }
                Spacer()
            }
            .font(.custom("Maplestory OTF Bold", size: 16))
        }
    }
    
    struct PresetPickerView: View {
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
                            .font(.mapleBold16)
                    })
                }
            }
        }
    }
}

#Preview {
    EquipmentView(viewModel: EquipmentViewModel())
}
