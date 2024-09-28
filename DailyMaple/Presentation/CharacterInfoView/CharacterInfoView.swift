//
//  CharacterInfoView.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/21/24.
//

import SwiftUI

struct CharacterInfoView: View {
    @StateObject private var viewModel = CharacterInfoViewModel()
    @StateObject private var statViewModel = CharacterStatViewModel()
    @StateObject private var equipViewModel = EquipmentViewModel()
    @StateObject private var symbolViewModel = SymbolViewModel()
    @StateObject private var hyperStatViewModel = HyperStatViewModel()
    
    var body: some View {
        VStack {
            if let character = viewModel.output.character {
                CharacterHeaderView(character: character)
                    .font(.mapleBold(16))
            }
            Picker("Menu", selection: $viewModel.output.picker) {
                ForEach(CharacterInfoViewModel.TapMenu.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .pickerStyle(.segmented)
            .colorMultiply(.legendary)
            .colorInvert()
                CharacterInfoTapView(
                    picker: viewModel.output.picker,
                    statViewModel: statViewModel,
                    equipViewModel: equipViewModel,
                    symbolViewModel: symbolViewModel,
                    hyperStatViewModel: hyperStatViewModel
                )
        }
        .background(Color.infoBackground)
    }
    
    struct CharacterHeaderView: View {
        let character: CharacterResponse
        
        func roundedText(_ name: String?, _ content: String, firstColor: Color, secondColor: Color, backColor: Color) -> some View {
            HStack {
                Spacer()
                if let name {
                    Text(name)
                        .foregroundStyle(firstColor)
                    Spacer()
                }
                Text(content)
                    .foregroundStyle(secondColor)
                
                Spacer()
            }
            .padding(.vertical, 5)
            .background(backColor)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .font(.mapleLight(12))
            
        }
        
        var body: some View {
            HStack {
                VStack(spacing: 10) {
                    roundedText(nil, character.character_class,
                                firstColor: .white,
                                secondColor: .white,
                                backColor: .gray)
                        .font(.mapleLight(14))
                    Spacer()
                    roundedText("유니온", "8888",
                                firstColor: .white,
                                secondColor: .black,
                                backColor: .gray)
                    roundedText("무릉도장", "75층",
                                firstColor: .white,
                                secondColor: .black,
                                backColor: .gray)
                    roundedText("인기도", "728",
                                firstColor: .white,
                                secondColor: .black,
                                backColor: .gray)
                }
                .padding(.horizontal)
                
                VStack {
                    roundedText(nil, "Lv. \(character.character_level)",
                                firstColor: .white,
                                secondColor: .white,
                                backColor: .gray)
                    AsyncImage(url: URL(string: character.character_image)) { result in
                        result.image?
                            .resizable()
                            .scaledToFill()
                    }
                    .frame(width: UIScreen.main.bounds.width / 4, height: UIScreen.main.bounds.width / 3)
                    roundedText(nil, character.character_name,
                                firstColor: .white,
                                secondColor: .white,
                                backColor: .rare)
                }
                .padding(.horizontal)
                
                VStack {
                    Spacer()
                    roundedText(nil, "길드",
                                firstColor: .white,
                                secondColor: .white,
                                backColor: .rare)
                    roundedText("길드", character.character_guild_name,
                                firstColor: .white,
                                secondColor: .black,
                                backColor: .gray)
                    roundedText("연합", character.character_guild_name,
                                firstColor: .white,
                                secondColor: .black,
                                backColor: .gray)
                }
                .padding(.horizontal)
            }
            .frame(height: UIScreen.main.bounds.height / 4)
        }
    }
    
    struct CharacterInfoTapView: View {
        let picker: CharacterInfoViewModel.TapMenu
        let statViewModel: CharacterStatViewModel
        let equipViewModel: EquipmentViewModel
        let symbolViewModel: SymbolViewModel
        let hyperStatViewModel: HyperStatViewModel
        var body: some View {
            switch picker {
            case .character:
                CharacterStatView(viewModel: statViewModel)
            case .equipment:
                EquipmentView(viewModel: equipViewModel)
            case .symbol:
                SymbolView(viewModel: symbolViewModel)
            case .hyperStat:
                HyperStatView(viewModel: hyperStatViewModel)
            }
        }
    }
}

#Preview {
    CharacterInfoView()
}
