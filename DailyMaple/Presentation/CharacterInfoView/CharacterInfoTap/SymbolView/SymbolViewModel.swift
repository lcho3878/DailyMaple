//
//  SymbolViewModel.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/22/24.
//

import Foundation
import Combine

final class SymbolViewModel: ObservableObject {
    typealias Symbol = SymbolResponseModel.Symbol

    private var cancellables = Set<AnyCancellable>()
    
    var input = Input()
    @Published var output = Output()
    
    struct Input {
        let ocid = PassthroughSubject<String, Never>()
    }
    
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
        input.ocid.sink { [weak self] ocid in
            guard let self else { return }
            BuildTestManager.shared.isNetworking ? loadSymbolData(ocid) : loadSymbolMockData()
        }
        .store(in: &cancellables)
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
    
    private func loadSymbolData(_ ocid: String) {
        Task {
            let result = try await APIManager.shared.callRequest(api: .characterSymbol(ocid: ocid), type: SymbolResponseModel.self)
            print("Symbol APIData Load")
            DispatchQueue.main.async { [weak self] in
                self?.output.symbols = result.symbol
            }
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
