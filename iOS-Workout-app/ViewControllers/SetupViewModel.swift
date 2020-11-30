//
//  SetupViewModel.swift
//  iOS-Workout-app
//
//  Created by Yael Bilu Eran on 29/11/2020.
//

import Foundation

enum sequenceResults {
    case completed, notComplete, failed
}

class SetupViewModel {
    
    private enum labelForTag: Int {
        case a = 1, b, c, d, e, f
        
        var text: String {
            switch self {
            case .a:
                return WorkoutService.shared.currentSequence == .setup ? "A": "1"
            case .b:
                return WorkoutService.shared.currentSequence == .setup ? "B": "2"
            case .c:
                return WorkoutService.shared.currentSequence == .setup ? "C": "3"
            case .d:
                return WorkoutService.shared.currentSequence == .setup ? "D": "4"
            case .e:
                return WorkoutService.shared.currentSequence == .setup ? "E": "5"
            case .f:
                return WorkoutService.shared.currentSequence == .setup ? "F": "6"
            }
        }
    }
    
    var currentCode: String = WorkoutService.shared.getSequence()
    var typedSequence = ""
    
    func onStart() {
        WorkoutService.shared.moveBackIfNeeded()
    }
    func getLabelForButton(tag: Int) -> String {
        return labelForTag(rawValue: tag)?.text ?? ""
    }
    
    func addDigite(tag: Int) -> sequenceResults {
        typedSequence.append(labelForTag(rawValue: tag)?.text ?? "")
        if typedSequence.lowercased() == currentCode {
            return .completed
        } else if currentCode.starts(with: typedSequence.lowercased()) {
            return .notComplete
        } else {
            typedSequence = ""
            return .failed
        }
    }
    
    
}
