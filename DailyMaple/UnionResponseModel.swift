//
//  UnionResponseModel.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/30/24.
//

import Foundation

struct UnionResponseModel: Decodable {
    let union_level: Int
    let union_grade: String
    let union_artifact_level: Int
    let union_artifact_point: Int
}
