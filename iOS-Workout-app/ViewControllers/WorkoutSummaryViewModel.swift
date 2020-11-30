//
//  WorkoutSummaryViewModel.swift
//  iOS-Workout-app
//
//  Created by Yael Bilu Eran on 30/11/2020.
//

import Foundation

class WorkoutSummaryViewModel {
    
    var summaryText: String {
        let workoutPercentageDone = WorkoutService.shared.workoutPercentageDone
        if workoutPercentageDone <= 0.3 {
            return "Not bad, try harder next time!"
        }
        if workoutPercentageDone <= 0.6 {
            return "Well done, you nailed it!"
        }
        return "Champion, it’s too easy for you!"
    }
}
