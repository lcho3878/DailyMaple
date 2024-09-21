//
//  CharacterInfoView.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/21/24.
//

import SwiftUI

struct CharacterInfoView: View {
    @StateObject private var viewModel = CharacterInfoViewModel()
    
    var body: some View {
        VStack {
            if let character = viewModel.output.character {
                CharacterHeaderView(character: character)
                    .font(.mapleBold16)
            }
            Picker("Menu", selection: $viewModel.output.picker) {
                ForEach(CharacterInfoViewModel.TapMenu.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .pickerStyle(.segmented)
            ScrollView {
                CharacterInfoTapView(picker: viewModel.output.picker)
            }
        }
    }
    
    struct CharacterHeaderView: View {
        let character: CharacterResponse
        var body: some View {
            HStack {
                AsyncImage(url: URL(string: character.character_image)) { result in
                    result.image?
                        .resizable()
                        .scaledToFill()
                }
                .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.width / 3)
                Spacer()
                
                VStack(alignment: .leading) {
                    Text(character.character_name)
                    Text(character.character_class)
                    Text("\(character.character_level) (\(character.character_exp_rate)%)")
                    Text(character.world_name)
                    Text(character.character_guild_name)
                }
                Spacer()
            }
            .padding()
        }
    }
    
    struct CharacterInfoTapView: View {
        let picker: CharacterInfoViewModel.TapMenu
        var body: some View {
            switch picker {
            case .character:
                CharacterStatView()
            case .equipment:
                Text(picker.rawValue)
            case .symbol:
                Text(picker.rawValue)
            case .hyperStat:
                Text(picker.rawValue)
            }
        }
    }
}

#Preview {
    CharacterInfoView()
}
