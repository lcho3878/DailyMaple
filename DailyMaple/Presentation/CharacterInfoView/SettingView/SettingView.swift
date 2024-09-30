//
//  SettingView.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/29/24.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject private var appRootManager: AppRootManager
    @StateObject private var viewModel = SettingViewModel()
    
    var body: some View {
        VStack {
            List {
                SomeButton(title: "대표 캐릭터 변경") {
                    viewModel.input.characterChangeTap.send(())
                }
                
//                SomeButton(title: "오픈소스 라이선스") {
//                    viewModel.input.licenseTap.send(())
//                }
                HStack {
                    Text("버전")
                    Spacer()
                    Text(currentAppVersion())
                        .foregroundStyle(.gray)
                }
            }
            .foregroundColor(.black)
            .font(.mapleBold(18))
            .alert("대표 캐릭터 변경", isPresented: $viewModel.output.characterAlert) {
                Button(role: .cancel) {
                } label: {
                    Text("취소")
                }
                Button(role: .destructive) {
                    appRootManager.ocid = nil
                    appRootManager.currentRoot = .ocid
                } label: {
                    Text("삭제")
                }
            } message: {
                Text("저장된 대표 캐릭터 정보가 삭제됩니다.")
            }

        }
     
    }
    func submit() {
        UserDefaultManager.ocid = nil
        appRootManager.currentRoot = .ocid
    }
    
    struct SomeButton: View {
        let title: String
        let hander: () -> Void
        var body: some View {
            Button {
                hander()
            } label: {
                Text(title)
            }
        }
    }
    
    private func currentAppVersion() -> String {
      if let info: [String: Any] = Bundle.main.infoDictionary,
          let currentVersion: String
            = info["CFBundleShortVersionString"] as? String {
            return currentVersion
      }
      return "nil"
    }
    
}

#Preview {
    SettingView()
}
