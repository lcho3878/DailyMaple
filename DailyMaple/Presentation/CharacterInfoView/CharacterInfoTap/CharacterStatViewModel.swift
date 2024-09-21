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
        do {
            guard let data = MockDataManager.shared.loadData(fileName: "Stats") else { return }
            let result = try JSONDecoder().decode(CharacterStatResponseModel.self, from: data)
//                print(result)
            output.stats = result
        }
        catch {
            
        }
    }
}
