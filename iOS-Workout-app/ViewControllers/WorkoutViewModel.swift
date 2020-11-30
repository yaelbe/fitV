//
//  WorkoutViewModel.swift
//  iOS-Workout-app
//
//  Created by Yael Bilu Eran on 29/11/2020.
//

import Foundation

class WorkoutViewModel {
    let exercises = WorkoutService.shared.getExercises()
    
    private var index: Int {
        set{
            WorkoutService.shared.execricesIndex = newValue
        }
        get {
            return WorkoutService.shared.execricesIndex
        }
    }
    
    var totalTime: Int {
        if index > 0 {
            var timePass = 0
            let exercises = WorkoutService.shared.getExercises()
            var currentIndex = 0
            
            while currentIndex < index {
                timePass += exercises[currentIndex].totalTime ?? 0
                currentIndex += 1
            }
            
            return (WorkoutService.shared.workoutTotalTime ?? 0) - timePass
        }
        return WorkoutService.shared.workoutTotalTime ?? 0
    }
    
    func getNextExercise() -> Exercise {
        let exercise = exercises[index]
        WorkoutService.shared.currentSequence = exercise.isBreakExercise() ? .between : .inside
        index += 1
        return exercise
    }
    
    func workoutDone(remainingTime: Int) {
        WorkoutService.shared.workoutDone(remainingTime: remainingTime)
    }
}
