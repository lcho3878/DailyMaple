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
    case characterStat(ocid: String)
    case characterHyperStat(ocid: String)
    case characterEquipment(ocid: String)
    case characterSymbol(ocid: String)
    case characterAbility(ocid: String)
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
        case .characterStat:
            return "/character/stat"
        case .characterHyperStat:
            return "/character/hyper-stat"
        case .characterEquipment:
            return "character/item-equipment"
        case .characterSymbol:
            return "character/symbol-equipment"
        case .characterAbility:
            return "character/ability"
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
        case .characterBasic(let ocid),
                .characterStat(let ocid),
                .characterHyperStat(let ocid),
                .characterEquipment(let ocid),
                .characterSymbol(let ocid),
                .characterAbility(let ocid):
            return [URLQueryItem(name: "ocid", value: ocid)]
        }
    }
}
