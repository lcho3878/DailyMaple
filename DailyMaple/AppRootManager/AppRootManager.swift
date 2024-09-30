//
//  AppRootManager.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/29/24.
//

import Foundation
import SwiftUI

final class AppRootManager: ObservableObject {

    @UserDefault(key: "ocid", defaultValue: nil, storage: .standard)
    var ocid: String?
    
    @UserDefault(key: "apikey", defaultValue: nil, storage: .standard)
    var apikey: String?
    
    @Published var currentRoot: AppRoot = .api
    
    init() {
//        if BuildTestManager.shared.isNetworking {
//            if apikey == nil {
//                currentRoot = .api
//            }
//            else 
        if ocid == nil {
            currentRoot = .ocid
        }
        else {
            currentRoot = .main
        }
//        }
//        else {
//            currentRoot = .main
//        }

    }
}

extension AppRootManager {
    enum AppRoot {
        case api
        case ocid
        case main
    }
}
