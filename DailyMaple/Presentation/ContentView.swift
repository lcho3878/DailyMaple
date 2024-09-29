//
//  ContentView.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/21/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        if let ocid = UserDefaults.standard.string(forKey: "ocid") {
            MainTabView()
        }
        else if let apiKey = UserDefaults.standard.string(forKey: "apiKey") {
            OcidCheckView()
        }
        else {
            APIKeyView()
        }
    }
}

#Preview {
    ContentView()
}
