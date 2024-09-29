//
//  ContentView.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/21/24.
//

import SwiftUI

struct ContentView: View {

    
    @StateObject private var appRootManager = AppRootManager()
    
    var body: some View {
        Group {
            switch appRootManager.currentRoot {
            case .api:
                APIKeyView()
            case .ocid:
                OcidView()
            case .main:
                MainTabView()
            }
        }
        .environmentObject(appRootManager)
        
    }
}

#Preview {
    ContentView()
}
