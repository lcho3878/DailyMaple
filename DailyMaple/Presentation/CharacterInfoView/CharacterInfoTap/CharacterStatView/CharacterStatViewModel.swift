//
//  CharacterStatViewModel.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/21/24.
//

import Foundation
import Combine

final class CharacterStatViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    
    var input = Input()
    @Published var output = Output()
    
    struct Input {
        let ocid = PassthroughSubject<String, Never>()
    }
    
    struct Output {
        var stats: CharacterStatResponseModel?
    }
    
    init() {
        input.ocid
            .sink { [weak self] ocid in
                guard let self else { return }
                BuildTestManager.shared.isNetworking ? loadStatData(ocid) : loadStatMockData()
            }
            .store(in: &cancellables)
    }
}

extension CharacterStatViewModel {
    private func loadStatMockData() {
        do {
            guard let data = MockDataManager.shared.loadData(fileName: "Stats") else { return }
            let result = try JSONDecoder().decode(CharacterStatResponseModel.self, from: data)
            print("Stat Mock Load")
            output.stats = result
        }
        catch {
            print("Error(Character Info): \(error)")
        }
    }
    
    private func loadStatData(_ ocid: String) {
        Task {
            let result = try await APIManager.shared.callRequest(api: .characterStat(ocid: ocid), type: CharacterStatResponseModel.self)
            print("Stat APIData Load")
            DispatchQueue.main.async { [weak self] in
                self?.output.stats = result
            }
        }
    }
}
