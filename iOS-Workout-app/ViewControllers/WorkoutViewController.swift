//
//  WorkoutViewController.swift
//  iOS-Workout-app
//
//  Created by Yael Bilu Eran on 29/11/2020.
//

import UIKit

class WorkoutViewController: UIViewController {
    
    //  MARK: outlets
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet weak var exerciseTimeLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    
    // MARK: proprieties
    let vModel = WorkoutViewModel()
    var timer:Timer?
    var timeLeft = 0
    var totalTimeLeft = 0
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        stopButton.layer.cornerRadius = 19
        totalTimeLabel.text = formattedTime(seconds: vModel.totalTime)
        totalTimeLeft = vModel.totalTime
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nextExercise()
    }
    
    func setupExercise(_ exercise: Exercise) {
        exerciseNameLabel.text = exercise.name
        exerciseTimeLabel.text = formattedTime(seconds: exercise.totalTime ?? 0)
        timeLeft = exercise.totalTime ?? 0
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
    }
    
    @IBAction func stopTapped() {
        timer?.invalidate()
        timer = nil
        
        let alert = UIAlertController(title: "Pause", message: "Are you sure you went to quite?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { [weak self] action in
            self?.performSegue(withIdentifier: "showSetup", sender: nil)
        }))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [weak self] action in
            self?.showSummary()
        }))
        self.present(alert, animated: true)
    }
    
    @objc func onTimerFires()
    {
        timeLeft -= 1
        totalTimeLeft -= 1
        totalTimeLabel.text = formattedTime(seconds: totalTimeLeft)
        exerciseTimeLabel.text = formattedTime(seconds: timeLeft)
        
        if totalTimeLeft <= 0 {
            timer?.invalidate()
            timer = nil
            showSummary()
        }

        if timeLeft <= 0 {
            timer?.invalidate()
            timer = nil
            nextExercise ()
        }
    }
    
    func nextExercise () {
        setupExercise(vModel.getNextExercise())
    }
    
    func showSummary() {
        vModel.workoutDone(remainingTime: totalTimeLeft)
        performSegue(withIdentifier: "showWorkoutSummary", sender: nil)
    }
}

extension  WorkoutViewController {
    private func formattedTime(seconds: Int) -> String {
        let (h, m, s) = secondsToHoursMinutesSeconds (seconds)
        var time = ""
        if h > 0 {
            time = "\(h):"
        }
        
        if m > 9 {
            time = "\(time)\(m):"
        } else {
            time = "\(time)0\(m):"
        }
        
        if s > 9 {
            time = "\(time)\(s)"
        } else {
            time = "\(time)0\(s)"
        }
        
        return time
    }
    
    private func secondsToHoursMinutesSeconds (_ seconds : Int) -> (Int, Int, Int) {
      return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
}
