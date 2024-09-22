//
//  SymbolViewModel.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/22/24.
//

import Foundation

final class SymbolViewModel: ObservableObject {
    @Published var output = Output()
    
    struct Output {
        var symbols: [SymbolResponseModel.Symbol] = []
    }
    
    init() {
        do {
            guard let data = MockDataManager.shared.loadData(fileName: "Symbol") else { return }
            let result = try JSONDecoder().decode(SymbolResponseModel.self, from: data)
            print("Symbol Info Load")
            output.symbols = result.symbol
        }
        catch{
            print("Error(Character Info): \(error)")
        }
    }
}
