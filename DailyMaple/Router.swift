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
    case union
    case characterBasic
    case characterPopularity
    case characterDojang
    case characterStat
    case characterHyperStat
    case characterEquipment
    case characterSymbol
    case characterAbility
    case notices
    case updates
    case events
    case cashUpdates
    case checkAPIValidation(key: String)
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
        case .union:
            return "/user/union"
        case .characterBasic:
            return "/character/basic"
        case .characterPopularity:
            return "/character/popularity"
        case .characterDojang:
            return "/character/dojang"
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
        case .notices:
            return "notice"
        case .updates:
            return "notice-update"
        case .events:
            return "notice-event"
        case .cashUpdates:
            return "notice-cashshop"
        case .checkAPIValidation:
            return "notice"
        }
    }
    
    var header: [String : String] {
        switch self {
        case .checkAPIValidation(let key):
            return [
                "x-nxopen-api-key": key,
                "accept": "application/json"
            ]
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
        case .characterBasic,
                .characterStat,
                .characterHyperStat,
                .characterEquipment,
                .characterSymbol,
                .characterAbility,
                .characterPopularity,
                .characterDojang,
                .union:
            return [URLQueryItem(name: "ocid", value: UserDefaultManager.ocid)]
        default: return nil
        }
    }
}
