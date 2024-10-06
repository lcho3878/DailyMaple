//
//  SearchTabView.swift
//  DailyMaple
//
//  Created by 이찬호 on 10/3/24.
//

import SwiftUI

struct SearchTabView: View {
    @StateObject private var viewModel = SearchTabViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("닉네임 입력")
                    .font(.mapleBold(20))
                TextField("캐릭터 닉네임을 입력해주세요.", text: $viewModel.input.nickname)
                    .padding(.vertical)
                    .background(.white)
                    .padding()
                Button {
                    viewModel.input.buttonTap.send(())
                } label: {
                    Text("확인")
                        .foregroundStyle(.black)
                        .padding()
                        .padding(.horizontal)
                        .background(.orange)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                NavigationLink(
                    destination: CharacterInfoView(viewType: .search),
                    isActive: $viewModel.output.isActive,
                    label: {
                        EmptyView()
                    })
            }
            .frame(maxHeight: .infinity)
            .background(Color.infoBackground, ignoresSafeAreaEdges: .top)
        }
        .font(.mapleBold(16))
        .alert(item: $viewModel.output.apiError) { item in
            Alert(title: Text(item.errorType.message), dismissButton: .default(Text("확인")))
        }
    }
}

#Preview {
//    SearchTabView()
    ContentView()
}
