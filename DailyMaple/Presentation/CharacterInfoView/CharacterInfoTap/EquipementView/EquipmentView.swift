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
            VStack(alignment: .trailing) {
                PresetPickerView(input: viewModel.input.pickerInput, output: $viewModel.output.pickerOutput)
                    .padding()
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
            .background(Color.infoBackground)
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
            .foregroundColor(.statTitle)
            .contentShape(.rect)
            .font(.mapleBold(16))
        }
    }
}

#Preview {
    EquipmentView(viewModel: EquipmentViewModel())
}
