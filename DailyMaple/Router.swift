//
//  Router.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/28/24.
//

import Foundation
import Alamofire

enum Router {
    case ocid(query: String)
    case characterBasic(ocid: String)
}

extension Router: TargetType {
    
    var baseURL: String {
        return "https://open.api.nexon.com/maplestory/v1"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .ocid:
            return "/id"
        case .characterBasic:
            return "/character/basic"
        }
    }
    
    var header: [String : String] {
        switch self {
        default:
            return [
                "x-nxopen-api-key": APIKey.key,
                "accept": "application/json"
            ]
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .ocid(let nick):
            return [URLQueryItem(name: "character_name", value: nick)]
        case .characterBasic(let ocid):
            return [URLQueryItem(name: "ocid", value: ocid)]
        }
    }
}
