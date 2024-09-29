//
//  SettingView.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/29/24.
//

import SwiftUI

struct SettingView: View {
    @StateObject private var viewModel = SettingViewModel()
    @State private var tempText = ""
    
    var body: some View {
        List {
            SomeButton(title: "대표 캐릭터 변경") {
                viewModel.input.characterChangeTap.send(())
            }
            SomeButton(title: "API 변경") {
                viewModel.input.apiChangeTap.send(())
            }
            SomeButton(title: "오픈소스 라이선스") {
                viewModel.input.licenseTap.send(())
            }
        }
        .alert("캐릭터 변경 alert", isPresented: $viewModel.output.characterAlert) {
              TextField("Enter your name", text: $tempText)
              Button("OK", action: submit)
          } message: {
              Text("Xcode will print whatever you type.")
          }
          .alert("apiAlert", isPresented: $viewModel.output.apiAlert) {
              Button(role: .cancel) {
                  print("Cancel Click")
              } label: {
                  Text("Cancel")
              }
              Button(role: .destructive) {
                  print("OK Click")
              } label: {
                  Text("OK")
              }

            } message: {
                Text("Xcode will print whatever you type.")
            }
        
     
    }
    func submit() {
        print("You entered \(tempText)")
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
    
}

#Preview {
    SettingView()
}
