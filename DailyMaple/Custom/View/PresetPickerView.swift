//
//  PresetPickerView.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/27/24.
//

import Foundation
import SwiftUI
import Combine

struct PresetPickerView: View {
    var input: PassthroughSubject<Int, Never>
    @Binding var output: Int
    
    var body: some View {
        HStack {
            Text("PRESETS")
            ForEach(1..<4) { num in
                Button(action: {
                    input.send(num)
                }, label: {
                    Text("\(num)")
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.white)
                        .background(output == num ? .black : Color.infoBackground)
                        .border(output == num ? .white : .black, width: 1)
                        .font(.mapleBold(16))
                })
            }
        }
        .padding(5)
        .background(Color(hex: 0x646f7c))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
