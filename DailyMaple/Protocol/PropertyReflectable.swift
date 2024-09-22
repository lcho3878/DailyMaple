//
//  PropertyReflectable.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/22/24.
//

import Foundation

protocol PropertyReflectable {}

extension PropertyReflectable {
    subscript(key: String) -> Any? {
        let m = Mirror(reflecting: self)
        for child in m.children {
            if child.label == key {
                return child.value
            }
        }
        return nil
    }
}
