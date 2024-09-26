//
//  SymbolView.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/22/24.
//

import SwiftUI

struct SymbolView: View {
    typealias Symbol = SymbolResponseModel.Symbol
    typealias Region = SymbolViewModel.Region
    
    @StateObject var viewModel: SymbolViewModel
    @State private var selectedSymbol: Symbol?
    
    var body: some View {
        let columns = Array(repeating: GridItem(.flexible(minimum: 10, maximum: UIScreen.main.bounds.width / 6)), count: 6)
        VStack {
            LazyVGrid(columns: columns) {
                ForEach(Region.allCases, id: \.rawValue) { region in
                    Section(region.rawValue) {
                        ForEach(region.symbols(symbols: viewModel.output.symbols), id: \.symbolCity) { symbol in
                            VStack {
                                SymbolRowView(symbol: symbol, selectedSymbol: $selectedSymbol)
                                    .onTapGesture {
                                        withAnimation {
                                            selectedSymbol = symbol
                                        }
                                    }
                            }
                        }
                    }
                    .font(.mapleBold(16))
                }
            }
            .padding(.horizontal)
            Spacer()
        }
        .background(selectedSymbol == nil ? Color(uiColor: .systemBackground) : .black.opacity(0.5))
        .background(ClearBackground())
        .overlay {
            if let symbol = selectedSymbol {
                VStack(alignment: .leading) {
                    Text(symbol.symbol_name)
                    Text("성장 레벨: \(symbol.symbol_level)")
                    Text("성장치 : \(symbol.symbol_growth_count)/\(symbol.symbol_require_growth_count)")
                    Text("\(symbol.forceName): +\(symbol.symbol_force)")
                    if symbol.symbol_str != "0" {
                        Text("STR: +\(symbol.symbol_str)")
                    }
                    if symbol.symbol_dex != "0" {
                        Text("DEX: +\(symbol.symbol_dex)")
                    }
                    if symbol.symbol_int != "0" {
                        Text("INT: +\(symbol.symbol_int)")
                    }
                    if symbol.symbol_luk != "0" {
                        Text("LUK: +\(symbol.symbol_luk)")
                    }
                    if symbol.symbol_str != "0" {
                        Text("HP: +\(symbol.symbol_str)")
                    }
                }
                .padding()
                .background(.background)
                .clipShape(.rect(cornerRadius: 30))
                .font(.mapleLight(16))
            }
        }
        .onTapGesture {
            withAnimation {
                selectedSymbol = nil
            }
        }
        
    }
    
    struct SymbolRowView: View {
        let symbol: Symbol
        @Binding var selectedSymbol: Symbol?
        
        var body: some View {
            VStack {
                AsyncImage(url: URL(string: symbol.symbol_icon)) { result in
                    if let image = result.image {
                        image
                            .resizable()
                            .scaledToFit()
                            .overlay(
                                selectedSymbol?.symbol_name == symbol.symbol_name ? Color.clear : selectedSymbol == nil ? Color.clear : Color.black.opacity(0.2)
                            )
                    }
                    else {
                        Image(systemName: "leaf.fill")
                            .resizable()
                            .scaledToFit()
                    }
                }
                .background(selectedSymbol?.symbol_name == symbol.symbol_name ? .gray : .clear)
                Text("Lv. \(symbol.symbol_level)")
            }
        }
    }
}

#Preview {
    SymbolView(viewModel: SymbolViewModel())
//    ContentView()
}
