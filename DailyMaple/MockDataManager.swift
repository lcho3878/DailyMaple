//
//  MockDataManager.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/21/24.
//

import Foundation

final class MockDataManager {
    static let shared = MockDataManager()
    
    private init() {}
    
    func loadData(fileName: String) -> Data? {
        let fileName = fileName
        let extensionType = "json"
        
        guard let fileLocation = Bundle.main.url(forResource: fileName, withExtension: extensionType) else { return nil }
        
        do {
            let data = try Data(contentsOf: fileLocation)
            return data
        }
        catch {
            return nil
        }
    }
}
