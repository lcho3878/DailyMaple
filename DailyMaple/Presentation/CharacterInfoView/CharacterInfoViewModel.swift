//
//  CharacterInfoViewModel.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/21/24.
//

import Foundation
import Combine
//import SwiftUI

final class CharacterInfoViewModel: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    var input = Input()
    @Published var output = Output()
    
    struct Input {
        
    }
    
    struct Output {
        var character: CharacterResponse?
        var picker: TapMenu = .character
        var popularity: Int = 0
        var dojang: Int = 0
        var unionLevel: Int = 0
    }
    
    init() {
        BuildTestManager.shared.isNetworking ? loadCharacterData() : loadCharacterMockData()
        BuildTestManager.shared.isNetworking ? loadCharacterPopData() : loadCharacterPopMockData()
        BuildTestManager.shared.isNetworking ? loadCharacterDojangData() : loadCharacterDojangMockData()
        BuildTestManager.shared.isNetworking ? loadUnionData() : loadUnionMockData()
    }
}

extension CharacterInfoViewModel {
    
    private func loadCharacterMockData() {
        do {
            guard let data = MockDataManager.shared.loadData(fileName: "Character") else { return }
            let result = try JSONDecoder().decode(CharacterResponse.self, from: data)
            print("Character Mock Load")
            output.character = result
        }
        catch {
            print("Error(Character Info): \(error)")
        }
    }
    
    private func loadCharacterData() {
        Task {
            let result = try await APIManager.shared.callRequest(api: .characterBasic, type: CharacterResponse.self)
            print("Character APIData Request")
            DispatchQueue.main.async { [weak self] in
                self?.output.character = result
            }

        }
    }
    
    private func loadCharacterPopMockData() {
        do {
            guard let data = MockDataManager.shared.loadData(fileName: "Popularity") else { return }
            let result = try JSONDecoder().decode(PopularityResponseModel.self, from: data)
            print("Popularity Mock Load")
            output.popularity = result.popularity
        }
        catch {
            print("Error(Character Info): \(error)")
        }
    }
    
    private func loadCharacterPopData() {
        Task {
            let result = try await APIManager.shared.callRequest(api: .characterPopularity, type: PopularityResponseModel.self)
            print("Popularity APIData Request")
            DispatchQueue.main.async { [weak self] in
                self?.output.popularity = result.popularity
            }
        }
    }
    
    private func loadCharacterDojangMockData() {
        do {
            guard let data = MockDataManager.shared.loadData(fileName: "Dojang") else { return }
            let result = try JSONDecoder().decode(DojangResponseModel.self, from: data)
            print("Dojang Mock Load")
            output.dojang = result.dojang_best_floor
        }
        catch {
            print("Error(Character Info): \(error)")
        }
    }
    
    private func loadCharacterDojangData() {
        Task {
            let result = try await APIManager.shared.callRequest(api: .characterDojang, type: DojangResponseModel.self)
            print("Dojang APIData Request")
            DispatchQueue.main.async { [weak self] in
                self?.output.dojang = result.dojang_best_floor
            }

        }
    }

    private func loadUnionMockData() {
        do {
            guard let data = MockDataManager.shared.loadData(fileName: "Union") else { return }
            let result = try JSONDecoder().decode(UnionResponseModel.self, from: data)
            print("Union Mock Load")
            output.unionLevel = result.union_level
        }
        catch {
            print("Error(Character Info): \(error)")
        }
    }
    
    private func loadUnionData() {
        Task {
            let result = try await APIManager.shared.callRequest(api: .union, type: UnionResponseModel.self)
            print("Union APIData Request")
            DispatchQueue.main.async { [weak self] in
                self?.output.unionLevel = result.union_level
            }
        }
    }
}

extension CharacterInfoViewModel {
    enum TapMenu: String, CaseIterable {
        case character = "캐릭터 정보"
        case hyperStat = "하이퍼스탯 / 어빌리티"
        case equipment = "장비"
        case symbol = "심볼"
    }
}
