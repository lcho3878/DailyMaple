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
        var hyperPickerOutput = 3
        var abilityPickerOutput = 3
    }
    
    init() {
        BuildTestManager.shared.isNetworking ? loadAbilityData() : loadAbilityMockData()
        BuildTestManager.shared.isNetworking ? loadHyperStatData() : loadHyperStatMockData()
        
        input.abilityPickerInput
            .sink { [weak self] picker in
                guard let self, let result = self.output.abilityResult else { return }
                switchingAbilityPreset(picker, result: result)
            }
            .store(in: &cancellables)
        
        input.hyperPickerInput
            .sink { [weak self] picker in
                guard let self, let result = self.output.hyperStatResult else { return }
                switchingHyperStatPreset(picker, result: result)
            }
            .store(in: &cancellables)
    }
}

extension HyperStatViewModel {
    private func loadAbilityMockData() {
        do {
            guard let data = MockDataManager.shared.loadData(fileName: "Ability") else { return }
            let result = try JSONDecoder().decode(AbilityResponseModel.self, from: data)
            print("Ability Mock Load")
            output.abilityResult = result
            switchingAbilityPreset(result.preset_no, result: result)
        }
        catch {
            print("Error(Ability Info): \(error)")
        }
    }
    
    private func loadHyperStatMockData() {
        do {
            guard let data = MockDataManager.shared.loadData(fileName: "HyperStat") else { return }
            let result = try JSONDecoder().decode(HyperStatResponseModel.self, from: data)
            print("HyperStat Mock Load")
            output.hyperStatResult = result
            switchingHyperStatPreset(Int(result.use_preset_no)!, result: result)
        }
        catch {
            print("Error(HyperStat Info): \(error)")
        }
    }
    
    private func loadAbilityData() {
        Task {
            let result = try await APIManager.shared.callRequest(api: .characterAbility, type: AbilityResponseModel.self)
            print("Ability APIData Load")
            DispatchQueue.main.async { [weak self] in
                self?.output.abilityResult = result
                self?.switchingAbilityPreset(result.preset_no, result: result)
            }
        }
    }
    
    private func loadHyperStatData() {
        Task {
            let result = try await APIManager.shared.callRequest(api: .characterHyperStat, type: HyperStatResponseModel.self)
            print("HyperStat APIData Load")
            DispatchQueue.main.async { [weak self] in
                self?.output.hyperStatResult = result
                self?.switchingHyperStatPreset(Int(result.use_preset_no)!, result: result)
            }
        }
    }
    
    private func switchingAbilityPreset(_ num: Int, result: AbilityResponseModel) {
        output.abilityPickerOutput = num
        switch output.abilityPickerOutput {
        case 1: output.ability = result.ability_preset_1
        case 2: output.ability = result.ability_preset_2
        case 3: output.ability = result.ability_preset_3
        default: break
        }
    }
    
    private func switchingHyperStatPreset(_ num: Int, result: HyperStatResponseModel) {
        output.hyperPickerOutput = num
        switch output.hyperPickerOutput {
        case 1: output.hyperStats = result.hyper_stat_preset_1
        case 2: output.hyperStats = result.hyper_stat_preset_2
        case 3: output.hyperStats = result.hyper_stat_preset_3
        default: break
        }
    }
}
