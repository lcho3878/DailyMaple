//
//  SymbolView.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/22/24.
//

import SwiftUI

struct SymbolView: View {
    @StateObject var viewModel: SymbolViewModel
    
    var body: some View {
        ForEach(viewModel.output.symbols, id: \.symbol_name) { symbol in
            Text(symbol.symbol_name)
        }
    }
}

#Preview {
    SymbolView(viewModel: SymbolViewModel())
}
