//
//  Exercises.swift
//  iOS-Workout-app
//
//  Created by Yael Bilu Eran on 29/11/2020.
//

import Foundation
struct Exercise: Codable {
    var id : String?
    var name : String?
    var startTime : Int?
    var totalTime : Int?

    enum CodingKeys: String, CodingKey {

        case id = "_id"
        case name = "name"
        case startTime = "start_time"
        case totalTime = "total_time"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        startTime = try values.decodeIfPresent(Int.self, forKey: .startTime)
        totalTime = try values.decodeIfPresent(Int.self, forKey: .totalTime)
    }
    
    init(_ id: String? = nil, name: String, startTime: Int, totalTime: Int) {
        self.id = id
        self.name = name
        self.startTime = startTime
        self.totalTime = totalTime
    }
    
    func isBreakExercise() -> Bool {
        return name == "break"
    }

}
