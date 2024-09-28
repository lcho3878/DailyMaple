//
//  APIManager.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/28/24.
//

import Foundation
import Alamofire

final class APIManager {
    
    static let shared = APIManager()
    
    private init() {}
    
    func callRequest<T: Decodable>(api: Router, type: T.Type) async throws -> T {
        let request = try api.asURLRequest()
        let result = AF.request(request)
            .validate()
            .serializingResponse(using: .decodable(of: T.self))
        
        switch await result.result {
        case .success(let v): return v
        case .failure(let e):
            print("error: \(e)")
            throw e
        }
    }
    
}
