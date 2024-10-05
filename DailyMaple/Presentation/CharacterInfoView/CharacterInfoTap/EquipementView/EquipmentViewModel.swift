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
        let ocid = PassthroughSubject<String, Never>()
        var selectedItem: Items.Item?
        var pickerInput = PassthroughSubject<Int, Never>()
    }
    
    struct Output {
        var result: Items?
        var items: [Items.Item] = []
        var pickerOutput: Int = 1
    }
    
    init() {
        input.ocid.sink { [weak self] ocid in
            guard let self else { return }
            BuildTestManager.shared.isNetworking ? loadEquipmentsData(ocid) : loadEquipmentsMockData()
        }
        .store(in: &cancellables)
        
       
        
        input.pickerInput
            .sink { [weak self] num in
                guard let self, let result = self.output.result else { return }
                switchingPreset(num, result: result)
            }
            .store(in: &cancellables)
    }
}

extension EquipmentViewModel {
    private func loadEquipmentsMockData() {
        do {
            guard let data = MockDataManager.shared.loadData(fileName: "Items") else { return }
            let result = try JSONDecoder().decode(EquipmentsResponseModel.self, from: data)
            print("Equipments Mock Load")
            output.result = result
            switchingPreset(result.preset_no, result: result)
            
        }
        catch {
            print("Error(Character Info): \(error)")
        }
    }
    
    private func loadEquipmentsData(_ ocid: String) {
        Task {
            let result = try await APIManager.shared.callRequest(api: .characterEquipment(ocid: ocid), type: EquipmentsResponseModel.self)
            print("Equipments APIData Load")
            DispatchQueue.main.async { [weak self] in
                self?.output.result = result
                self?.switchingPreset(result.preset_no, result: result)
            }
        }
    }
    
    private func switchingPreset(_ num: Int, result: Items) {
        output.pickerOutput = num
        print("equit presetnum: \(num)")
        switch num {
        case 1: output.items = result.item_equipment_preset_1
        case 2: output.items = result.item_equipment_preset_2
        case 3: output.items = result.item_equipment_preset_3
        default: output.items = result.item_equipment
        }
    }
}
