//
//  WorkoutDetails.swift
//  iOS-Workout-app
//
//  Created by Yael Bilu Eran on 29/11/2020.
//

import Foundation
struct WorkoutDetails : Codable {
    let id : String?
    let totalTime : Int?
    let exercises : [Exercise]?
    let setupSequence : String?
    let reSetupSequence : [ResetupSequence]?
    let createdAt : String?
    let updatedAt : String?
    let __v : Int?

    enum CodingKeys: String, CodingKey {

        case id = "_id"
        case totalTime = "total_time"
        case exercises = "exercises"
        case setupSequence = "setup_sequence"
        case reSetupSequence = "re_setup_sequence"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case __v = "__v"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        totalTime = try values.decodeIfPresent(Int.self, forKey: .totalTime)
        exercises = try values.decodeIfPresent([Exercise].self, forKey: .exercises)
        setupSequence = try values.decodeIfPresent(String.self, forKey: .setupSequence)
        reSetupSequence = try values.decodeIfPresent([ResetupSequence].self, forKey: .reSetupSequence)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        __v = try values.decodeIfPresent(Int.self, forKey: .__v)
    }

}
