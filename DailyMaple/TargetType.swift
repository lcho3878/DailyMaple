//
//  TargetType.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/28/24.
//

import Foundation
import Alamofire

protocol TargetType: URLRequestConvertible {
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var header: [String: String] { get }
    var queryItems: [URLQueryItem]? { get }
}

extension TargetType {
    func asURLRequest() throws -> URLRequest {
        var url = try baseURL.asURL()
        url.append(queryItems: queryItems ?? [])
        var request = try URLRequest(
            url: url.appendingPathComponent(path),
            method: method
        )
        request.allHTTPHeaderFields = header
        return request
    }
}
