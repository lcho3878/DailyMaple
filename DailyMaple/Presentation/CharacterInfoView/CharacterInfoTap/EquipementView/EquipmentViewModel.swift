//
//  EquipmentViewModel.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/22/24.
//

import Foundation

final class EquipmentViewModel: ObservableObject {
    
    typealias Items = EquipmentsResponseModel
    
    @Published var input = Input()
    @Published var output = Output()
    
    struct Input {
        var selectedItem: Items.Item?
    }
    
    struct Output {
        var items: [Items.Item] = []
    }
    
    init() {
        do {
            guard let data = MockDataManager.shared.loadData(fileName: "Items") else { return }
            let result = try JSONDecoder().decode(Items.self, from: data)
            print("equipments load")
            output.items = result.item_equipment
        }
        catch {
            print("실패 \(error)")
        }
    }
}
