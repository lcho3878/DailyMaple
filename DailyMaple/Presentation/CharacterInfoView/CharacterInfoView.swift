//
//  CharacterInfoView.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/21/24.
//

import SwiftUI

struct CharacterInfoView: View {
    var viewType: ViewType?
    
    @ObservedObject private var viewModel = CharacterInfoViewModel()
    @StateObject private var statViewModel = CharacterStatViewModel()
    @StateObject private var equipViewModel = EquipmentViewModel()
    @StateObject private var symbolViewModel = SymbolViewModel()
    @StateObject private var hyperStatViewModel = HyperStatViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                VStack {
                    VStack {
                        if let character = viewModel.output.character {
                            CharacterHeaderView(viewModel: viewModel, character: character)
                                .font(.mapleBold(16))
     
                        }
                        else {
                            SettingButtonView()
                        }
                    }
                    .padding(.vertical)
                    Picker("Menu", selection: $viewModel.output.picker) {
                        ForEach(CharacterInfoViewModel.TapMenu.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .padding(.top)
                    .pickerStyle(.segmented)
                    .colorMultiply(.rare)
                    .colorInvert()
                }
                .background(Color.infoBackground)
                CharacterInfoTapView(
                    picker: viewModel.output.picker,
                    statViewModel: statViewModel,
                    equipViewModel: equipViewModel,
                    symbolViewModel: symbolViewModel,
                    hyperStatViewModel: hyperStatViewModel
                )
            }
        }
        .task {
            guard let viewType else { return }
            switch viewType {
            case .main:
                guard let userOcid = UserDefaultManager.ocid else { return }
                viewModel.input.ocid.send(userOcid)
                statViewModel.input.ocid.send(userOcid)
                equipViewModel.input.ocid.send(userOcid)
                symbolViewModel.input.ocid.send(userOcid)
                hyperStatViewModel.input.ocid.send(userOcid)
            case .search:
                guard let serachOcid = UserDefaultManager.searchOcid else { return }
                viewModel.input.ocid.send(serachOcid)
                statViewModel.input.ocid.send(serachOcid)
                equipViewModel.input.ocid.send(serachOcid)
                symbolViewModel.input.ocid.send(serachOcid)
                hyperStatViewModel.input.ocid.send(serachOcid)
            }
        }
    }
    
    struct CharacterHeaderView: View {
        @ObservedObject var viewModel: CharacterInfoViewModel
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
                    roundedText("유니온", "\(viewModel.output.unionLevel)",
                                firstColor: .white,
                                secondColor: .black,
                                backColor: .gray)
                    roundedText("무릉도장", "\(viewModel.output.dojang)층",
                                firstColor: .white,
                                secondColor: .black,
                                backColor: .gray)
                    roundedText("인기도", "\(viewModel.output.popularity)",
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
                    roundedText(nil, character.world_name, firstColor: .white, secondColor: .white, backColor: .gray)
                    roundedText(nil, character.character_name,
                                firstColor: .white,
                                secondColor: .white,
                                backColor: .rare)
                }
                .padding(.horizontal)
                
                VStack {
                    SettingButtonView()
                    Spacer()
                    roundedText(nil, "길드",
                                firstColor: .white,
                                secondColor: .white,
                                backColor: .rare)
                    roundedText("길드", character.character_guild_name ?? " - ",
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
    
    struct SettingButtonView: View {
        var body: some View {
            NavigationLink {
                SettingView()
            } label: {
                HStack {
                    Spacer()
                    Image(systemName: "gearshape.fill")
                        .resizable()
                        .frame(maxWidth: 30, maxHeight: 30)
                }
                .foregroundColor(.statTitle)
            }
        }
    }
}

extension CharacterInfoView {
    enum ViewType {
        case main
        case search
    }
}

#Preview {
//    CharacterInfoView()
    ContentView()
}
