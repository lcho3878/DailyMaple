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
        // Character Data Load
        do {
            guard let data = MockDataManager.shared.loadData(fileName: "Character") else { return }
            let result = try JSONDecoder().decode(CharacterResponse.self, from: data)
            print("Character Info Load")
            output.character = result
        }
        catch{
            print("Error(Character Info): \(error)")
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
