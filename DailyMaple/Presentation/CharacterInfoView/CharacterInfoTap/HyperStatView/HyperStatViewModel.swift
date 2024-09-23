//
//  HyperStatViewModel.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/23/24.
//

import Foundation
import Combine

final class HyperStatViewModel: ObservableObject {
    typealias HyperStat = HyperStatResponseModel.HyperStat
    typealias Ability = AbilityResponseModel.Ability
    
    private var cancellables = Set<AnyCancellable>()
    
    var input = Input()
    @Published var output = Output()
    
    struct Input {
        var hyperPickerInput = PassthroughSubject<Int, Never>()
        var abilityPickerInput = PassthroughSubject<Int, Never>()
    }
    
    struct Output {
        var hyperStatResult: HyperStatResponseModel?
        var abilityResult: AbilityResponseModel?
        var hyperStats: [HyperStat] = []
        var ability: Ability = Ability(ability_preset_grade: "", ability_info: [])
        var hyperPickerOutput = 1
        var abilityPickerOutput = 3
    }
    
    init() {
        do {
            guard let data = MockDataManager.shared.loadData(fileName: "HyperStat") else { return }
            let hyperStatResult = try JSONDecoder().decode(HyperStatResponseModel.self, from: data)
            output.hyperPickerOutput = Int(hyperStatResult.use_preset_no)!
            switch output.hyperPickerOutput {
            case 1: output.hyperStats = hyperStatResult.hyper_stat_preset_1
            case 2: output.hyperStats = hyperStatResult.hyper_stat_preset_2
            case 3: output.hyperStats = hyperStatResult.hyper_stat_preset_3
            default: break
            }
            output.hyperStatResult = hyperStatResult
            print("Load hyperstat")
        }
        catch {
            
        }
        do {
            guard let data = MockDataManager.shared.loadData(fileName: "Ability") else { return }
            let abilityResult = try JSONDecoder().decode(AbilityResponseModel.self, from: data)
            output.abilityPickerOutput = abilityResult.preset_no
            switch output.abilityPickerOutput {
            case 1: output.ability = abilityResult.ability_preset_1
            case 2: output.ability = abilityResult.ability_preset_2
            case 3: output.ability = abilityResult.ability_preset_3
            default: break
            }
            output.abilityResult = abilityResult
//            output.result = result
            print("Ability hyperstat")
        }
        catch {
            
        }
        
        input.hyperPickerInput
            .sink { [weak self] picker in
                guard let self else { return }
                self.output.hyperPickerOutput = picker
                guard let result = self.output.hyperStatResult else { return }
                switch output.hyperPickerOutput {
                case 1: output.hyperStats = result.hyper_stat_preset_1
                case 2: output.hyperStats = result.hyper_stat_preset_2
                case 3: output.hyperStats = result.hyper_stat_preset_3
                default: break
                }
            }
            .store(in: &cancellables)
        
        input.abilityPickerInput
            .sink { [weak self] picker in
                guard let self else { return }
                self.output.abilityPickerOutput = picker
                guard let result = self.output.abilityResult else { return }
                switch output.abilityPickerOutput {
                case 1: output.ability = result.ability_preset_1
                case 2: output.ability = result.ability_preset_2
                case 3: output.ability = result.ability_preset_3
                default: break
                }
            }
            .store(in: &cancellables)
    }
}
