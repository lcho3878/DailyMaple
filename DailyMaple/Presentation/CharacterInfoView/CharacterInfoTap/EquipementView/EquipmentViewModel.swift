//
//  EquipmentViewModel.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/22/24.
//

import Foundation
import Combine

final class EquipmentViewModel: ObservableObject {
    
    typealias Items = EquipmentsResponseModel
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var input = Input()
    @Published var output = Output()
    
    struct Input {
        var selectedItem: Items.Item?
        var pickerInput = PassthroughSubject<Int, Never>()
    }
    
    struct Output {
        var result: Items?
        var items: [Items.Item] = []
        var pickerOutput: Int = 1
    }
    
    init() {
        do {
            guard let data = MockDataManager.shared.loadData(fileName: "Items") else { return }
            let result = try JSONDecoder().decode(Items.self, from: data)
            print("equipments load")
            output.result = result
            output.pickerOutput = result.preset_no
            switch output.pickerOutput {
            case 1: output.items = result.item_equipment_preset_1
            case 2: output.items = result.item_equipment_preset_2
            case 3: output.items = result.item_equipment_preset_3
            default: output.items = result.item_equipment
            }
        }
        catch {
            print("실패 \(error)")
        }
        
        input.pickerInput
            .sink { [weak self] num in
                guard let self, let result = self.output.result else { return }
                output.pickerOutput = num
                switch num {
                case 1: output.items = result.item_equipment_preset_1
                case 2: output.items = result.item_equipment_preset_2
                case 3: output.items = result.item_equipment_preset_3
                default: output.items = result.item_equipment
                }
            }
            .store(in: &cancellables)
    }
}
