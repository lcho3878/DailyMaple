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
        case .failure(let error):
            if let responseData = await result.response.data{
                do {
                    let apiError = try JSONDecoder().decode(APIErrorResponse.self, from: responseData)
                    throw apiError
                } catch {
                    guard let apiError = error as? APIErrorResponse else { throw APIErrorResponse.unknown}
                    throw apiError
                }
            }
            else {
                throw APIErrorResponse.unknown
            }
        }
    }
    
}
// MARK: - Items


// MARK: - Error



