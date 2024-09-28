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
        // Mock Data
        loadStatMockData()
        
        // Real API Request with TestOcid
//        callTestRequest()
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
            let result = try await APIManager.shared.callRequest(api: .characterStat(ocid: APIKey.fakerOcid), type: CharacterStatResponseModel.self)
            print("Stat APIData Load")
            output.stats = result
        }
    }
}
