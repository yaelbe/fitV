//
//  Re_setup_sequence.swift
//  iOS-Workout-app
//
//  Created by Yael Bilu Eran on 29/11/2020.
//

import Foundation
struct ResetupSequence : Codable {
    let id : String?
    let type : String?
    let code : Int?

    enum CodingKeys: String, CodingKey {

        case id = "_id"
        case type = "type"
        case code = "code"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
    }

}
