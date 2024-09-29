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
    }
    
    init() {
        BuildTestManager.shared.isNetworking ? loadCharacterData() : loadCharacterMockData()
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
}

extension CharacterInfoViewModel {
    enum TapMenu: String, CaseIterable {
        case character = "캐릭터 정보"
        case hyperStat = "하이퍼스탯 / 어빌리티"
        case equipment = "장비"
        case symbol = "심볼"
    }
}
