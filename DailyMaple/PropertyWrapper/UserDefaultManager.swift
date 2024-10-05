//
//  UserDefaultManager.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/30/24.
//

import Foundation

struct UserDefaultManager {
    @UserDefault(key: "ocid", defaultValue: nil, storage: .standard)
    static var ocid: String?
    @UserDefault(key: "searchOcid", defaultValue: nil, storage: .standard)
    static var searchOcid: String?
}
