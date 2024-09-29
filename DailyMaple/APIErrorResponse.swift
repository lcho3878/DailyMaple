//
//  APIErrorResponse.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/29/24.
//

import Foundation

struct APIErrorResponse: Decodable, Error, Identifiable {
    let error: APIErrorDetail
    
    var id: String {
        return error.name
    }
    
    var errorType: ErrorType {
        guard let errorType = ErrorType(rawValue: error.name) else { return ErrorType.unknown }
        return errorType
    }
    
    static var unknown: APIErrorResponse {
        return APIErrorResponse(error: APIErrorDetail(name: "", message: "알 수 없는 오류가 발생했습니다."))
    }
    
    struct APIErrorDetail: Decodable {
        let name, message: String
    }
    
    enum ErrorType: String {
        case serverError = "OPENAPI00001"
        case forbidden = "OPENAPI00002"
        case invalidIdentifier = "OPENAPI00003"
        case invalidParameter = "OPENAPI00004"
        case invalidAPIKey = "OPENAPI00005"
        case invalidAPIPath = "OPENAPI00006"
        case tooManyRequest = "OPENAPI00007"
        case preparingData = "OPENAPI00009"
        case gameMaintenance = "OPENAPI000010"
        case serviceUnavailable = "OPENAPI000011"
        case unknown = "unknown"
        
        var message: String {
            switch self {
            case .serverError:
                "서버 내부 오류"
            case .forbidden:
                "권한이 없는 경우"
            case .invalidIdentifier:
                "유효하지 않은 식별자"
            case .invalidParameter:
                "파라미터 누락 또는 유효하지 않음"
            case .invalidAPIKey:
                "유효하지 않은 API KEY"
            case .invalidAPIPath:
                "유효하지 않은 게임 또는 API PATH"
            case .tooManyRequest:
                "API 호출량 초과"
            case .preparingData:
                "데이터 준비 중"
            case .gameMaintenance:
                "게임 점검 중"
            case .serviceUnavailable:
                "API 점검 중"
            case .unknown:
                "알 수 없는 오류 발생"
            }
        }
    }
}
