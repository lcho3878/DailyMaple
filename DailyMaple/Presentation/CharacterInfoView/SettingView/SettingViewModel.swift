//
//  SettingViewModel.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/29/24.
//

import Foundation
import Combine

final class SettingViewModel: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    
    var input = Input()
    @Published var output = Output()
    
    struct Input {
        let characterChangeTap = PassthroughSubject<Void, Never>()
        let apiChangeTap = PassthroughSubject<Void, Never>()
        let licenseTap = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var characterAlert = false
        var apiAlert = false
        var licenseAlert = false
    }
    
    init() {
        input.characterChangeTap
            .sink { [weak self] _ in
                self?.output.characterAlert = true
            }
            .store(in: &cancellables)
        
        input.apiChangeTap
            .sink { [weak self] _ in
                self?.output.apiAlert = true
            }
            .store(in: &cancellables)
        
        input.licenseTap
            .sink { [weak self] _ in
                self?.output.licenseAlert = true
            }
            .store(in: &cancellables)
    }
    
}

