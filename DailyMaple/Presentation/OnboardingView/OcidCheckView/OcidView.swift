//
//  OcidView.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/29/24.
//

import SwiftUI

struct OcidView: View {
    @EnvironmentObject private var appRootManager: AppRootManager
    @StateObject private var viewModel = OcidViewModel()
    
    var body: some View {
        VStack {
            Text("닉네임 입력")
                .font(.mapleBold(20))
            TextField("대표 캐릭터로 설정할 닉네임을 검색해주세요.", text: $viewModel.input.nickname)
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
        }
        .onChange(of: viewModel.output.ocid) { ocid in
            appRootManager.ocid = ocid
            appRootManager.currentRoot = .main
        }
        .font(.mapleBold(16))
        .frame(maxHeight: .infinity)
        .background(Color.infoBackground)
        .alert(item: $viewModel.output.apiError) { item in
            Alert(title: Text(item.errorType.message), dismissButton: .default(Text("확인")))
        }
    }
}

#Preview {
    OcidView()
}
