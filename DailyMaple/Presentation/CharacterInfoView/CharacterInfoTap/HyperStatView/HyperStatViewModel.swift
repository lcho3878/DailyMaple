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
    
    private var cancellables = Set<AnyCancellable>()
    
    var input = Input()
    @Published var output = Output()
    
    struct Input {
        var pickerInput = PassthroughSubject<Int, Never>()
    }
    
    struct Output {
        var result: HyperStatResponseModel?
        var hyperStats: [HyperStat] = []
        var pickerOutput = 1
    }
    
    init() {
        do {
            guard let data = MockDataManager.shared.loadData(fileName: "HyperStat") else { return }
            let result = try JSONDecoder().decode(HyperStatResponseModel.self, from: data)
            output.pickerOutput = Int(result.use_preset_no)!
            switch output.pickerOutput {
            case 1: output.hyperStats = result.hyper_stat_preset_1
            case 2: output.hyperStats = result.hyper_stat_preset_2
            case 3: output.hyperStats = result.hyper_stat_preset_3
            default: break
            }
            output.result = result
            print("Load hyperstat")
        }
        catch {
            
        }
        
        input.pickerInput
            .sink { [weak self] picker in
                guard let self else { return }
                self.output.pickerOutput = picker
                guard let result = self.output.result else { return }
                switch output.pickerOutput {
                case 1: output.hyperStats = result.hyper_stat_preset_1
                case 2: output.hyperStats = result.hyper_stat_preset_2
                case 3: output.hyperStats = result.hyper_stat_preset_3
                default: break
                }
            }
            .store(in: &cancellables)
    }
}
