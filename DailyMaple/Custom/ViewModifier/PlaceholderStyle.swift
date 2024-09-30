//
//  PlaceholderStyle.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/30/24.
//

import Foundation
import SwiftUI

public struct PlaceholderStyle: ViewModifier {
    var showPlaceHolder: Bool
    var placeholder: String
    
    public func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if showPlaceHolder {
                Text(placeholder)
                    .foregroundStyle(.gray)
            }
            content
        }
    }
}
