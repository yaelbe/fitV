//
//  Exercises_completed.swift
//  iOS-Workout-app
//
//  Created by Yael Bilu Eran on 29/11/2020.
//

import Foundation
struct ExercisesCompleted : Codable {
    let name : String?
    let totalTime : Int?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case totalTime = "total_time"
    }

    init(name: String?, totalTime: Int?) {
        self.name = name
        self.totalTime = totalTime
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        totalTime = try values.decodeIfPresent(Int.self, forKey: .totalTime)
    }

}
