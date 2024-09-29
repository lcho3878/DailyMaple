//
//  CharacterStatViewModel.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/21/24.
//

import Foundation

final class CharacterStatViewModel: ObservableObject {
    @Published var output = Output()
    
    struct Output {
        var stats: CharacterStatResponseModel?
    }
    
    init() {
        BuildTestManager.shared.isNetworking ? loadStatData() : loadStatMockData()
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
    
    private func loadStatData() {
        Task {
            let result = try await APIManager.shared.callRequest(api: .characterStat, type: CharacterStatResponseModel.self)
            print("Stat APIData Load")
            DispatchQueue.main.async { [weak self] in
                self?.output.stats = result
            }
        }
    }
}
