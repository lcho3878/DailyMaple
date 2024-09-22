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
    
    var body: some View {
        let columns = Array(repeating: GridItem(.flexible(minimum: 10, maximum: UIScreen.main.bounds.width / 6)), count: 6)
        VStack {
            LazyVGrid(columns: columns) {
                ForEach(Region.allCases, id: \.rawValue) { region in
                    Section(region.rawValue) {
                        ForEach(region.symbols(symbols: viewModel.output.symbols), id: \.symbolCity) { symbol in
                            SymbolRowView(symbol: symbol)
                        }
                    }
                    .font(.mapleBold16)
                }
            }
            Spacer()
        }
    }
    
    struct SymbolRowView: View {
        let symbol: Symbol
        
        var body: some View {
            VStack(alignment: .center) {
                AsyncImage(url: URL(string: symbol.symbol_icon)) { result in
                    if let image = result.image {
                        image
                            .resizable()
                            .scaledToFit()
                    }
                    else {
                        Image(systemName: "leaf.fill")
                            .resizable()
                            .scaledToFit()
                    }
                }
                Text("Lv. \(symbol.symbol_level)")
            }
        }
    }
}

#Preview {
//    SymbolView(viewModel: SymbolViewModel())
    ContentView()
}
