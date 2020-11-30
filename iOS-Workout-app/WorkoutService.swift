//
//  WorkoutService.swift
//  iOS-Workout-app
//
//  Created by Yael Bilu Eran on 29/11/2020.
//

import Foundation

enum sequenceType: String {
    case setup, inside, between
}

class WorkoutService {
    
    // MARK: - shared
    static let shared = WorkoutService()
    
    // MARK: - internal vars
    private var workoutDetails: WorkoutDetails? = nil
    private var timePass: Int = 0
    
    // MARK: - public vars
    var timeLeft = 0
    var currentSequence: sequenceType = .setup
    var workoutTotalTime: Int? {
        return workoutDetails?.totalTime
    }
    var execricesIndex = 0
    var workoutPercentageDone: Double = 0
    
    // MARK: network api calles
    func loadData(completion: @escaping(Bool) ->()) {
        DataProvider.shared.fetchWorkoutDetails { [weak self] result in
            switch result {
            case .success(let workoutDetails):
                guard let workoutDetails = workoutDetails else { return }
                self?.workoutDetails = workoutDetails
                completion(true)
            case .failure(let error):
                print("the error \(error)")
                completion(false)
            }
        }
    }
    
    func addWorkoutSummary() {
        let exercisesDone = getExercises()[0..<execricesIndex].filter{$0.name != "break"}
        var exercisesCompleted: [ExercisesCompleted] = []
        for exercise in exercisesDone {
            exercisesCompleted.append(ExercisesCompleted(name: exercise.name, totalTime: exercise.totalTime))
        }
       
        let workoutSummary = WorkoutSummary(totalTimeCompleted: Int(workoutPercentageDone * 100), exercisesCompleted:exercisesCompleted)
        DataProvider.shared.addWorkoutSummary(summary: workoutSummary){ result in
            //nothing to do here
        }
    }
    
    //MARK: public functions
    
    func getSequence() -> String {
        guard let workoutDetails = self.workoutDetails else {
            return ""
        }
        //if there is need for restart code, we want to go back to the start of the current execrice
        if currentSequence != .setup && execricesIndex > 0 {
            execricesIndex -= 1
        }
        
        switch currentSequence {
        case .setup:
            return workoutDetails.setupSequence ?? ""
        case .inside:
            return String(workoutDetails.reSetupSequence?.first{$0.type == "inside"}?.code ?? 0)
        case .between:
            return String(workoutDetails.reSetupSequence?.first{$0.type == "between"}?.code ?? 0)
        }
    }
    
    func getExercises() -> [Exercise] {
        guard let workoutDetails = self.workoutDetails else {
            return []
        }
        
        var exercisesWithBreak: [Exercise] = []
        if let exercises = workoutDetails.exercises {
            for exercise in exercises {
                if let startTime = exercise.startTime {
                    if startTime > 0 {
                        let breakExercise = Exercise(name: "break", startTime: 0, totalTime: startTime)
                        exercisesWithBreak.append(breakExercise)
                    }
                    exercisesWithBreak.append(exercise)
                }
            }
        }
        return exercisesWithBreak
    }
    
    func workoutDone(remainingTime: Int) {
        if let workoutTotalTime = workoutTotalTime {
            workoutPercentageDone = Double(workoutTotalTime - remainingTime)/Double(workoutTotalTime)
        }
        addWorkoutSummary()
    }
}
