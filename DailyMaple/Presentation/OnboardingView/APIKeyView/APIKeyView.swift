//
//  APIKeyView.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/29/24.
//

import SwiftUI

struct APIKeyView: View {
    
    @EnvironmentObject private var appRootManager: AppRootManager
    
    @StateObject private var viewModel = APIKeyViewModel()
    
    var body: some View {
        VStack {
            Text("APIKey 입력")
                .font(.mapleBold(20))
            TextField("발급받은 APIKey를 입력해주세요.", text: $viewModel.input.key)
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
        .onChange(of: viewModel.output.key) { key in
            appRootManager.apikey = key
            appRootManager.currentRoot = .ocid
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
    APIKeyView()
}
