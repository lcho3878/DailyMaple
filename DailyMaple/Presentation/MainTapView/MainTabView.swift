//
//  MainTabView.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/23/24.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            CharacterInfoView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("캐릭터 정보")
                }
            VStack {
                Text("Event View")
            }
            .tabItem {
                Image(systemName: "calendar")
                Text("이벤트")
            }
            
            VStack {
                DailyQuestView()
            }
            .tabItem {
                Image(systemName: "note.text")
                Text("메할일")
            }
        }
    }
}

#Preview {
    MainTabView()
}
