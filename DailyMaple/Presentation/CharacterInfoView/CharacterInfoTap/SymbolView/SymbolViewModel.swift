//
//  SymbolViewModel.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/22/24.
//

import Foundation

final class SymbolViewModel: ObservableObject {
    typealias Symbol = SymbolResponseModel.Symbol
    
    @Published var output = Output()
    
    struct Output {
        var symbols: [Symbol] = []
        var arcaneSymbols: [Symbol] {
            return symbols.filter { $0.symbolRegion == Region.arcane.rawValue}
        }
        
        var authenticSymbols: [Symbol] {
            return symbols.filter { $0.symbolRegion == Region.authentic.rawValue }
        }
        
        var grandAuthenticSymbols: [Symbol] {
            return symbols.filter { $0.symbolRegion == Region.grandAuthentic.rawValue }
        }
    }
    
    init() {
        // Mock Data
        loadSymbolMockData()
        
        // Real API Request with TestOcid
//        callTestRequest()
    }
}

extension SymbolViewModel {
    private func loadSymbolMockData() {
        do {
            guard let data = MockDataManager.shared.loadData(fileName: "Symbol") else { return }
            let result = try JSONDecoder().decode(SymbolResponseModel.self, from: data)
            print("Symbol Mock Load")
            output.symbols = result.symbol
        }
        catch {
            print("Error(Character Info): \(error)")
        }
    }
    
    private func loadSymbolData() {
        Task {
            let result = try await APIManager.shared.callRequest(api: .characterSymbol(ocid: APIKey.blackOcid), type: SymbolResponseModel.self)
            print("Symbol APIData Load")
            output.symbols = result.symbol
        }
    }
}

extension SymbolViewModel {
    enum Region: String, CaseIterable {
        case arcane = "아케인심볼"
        case authentic = "어센틱심볼"
        case grandAuthentic = "그랜드 어센틱심볼"
        
        func symbols(symbols ad: [Symbol]) -> [Symbol] {
            return ad.filter{ $0.symbolRegion == self.rawValue }
        }
    }
}
