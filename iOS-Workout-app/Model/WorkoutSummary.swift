//
//  WorkoutSummary.swift
//  iOS-Workout-app
//
//  Created by Yael Bilu Eran on 29/11/2020.
//

import Foundation

import Foundation
struct WorkoutSummary : Codable {
    let totalTimeCompleted : Int?
    let exercisesCompleted : [ExercisesCompleted]?

    enum CodingKeys: String, CodingKey {
        case totalTimeCompleted = "total_time_completed"
        case exercisesCompleted = "exercises_completed"
    }

//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        totalTimeCompleted = try values.decodeIfPresent(Int.self, forKey: .totalTimeCompleted)
//        exercisesCompleted = try values.decodeIfPresent([ExercisesCompleted].self, forKey: .exercisesCompleted)
//    }

}
