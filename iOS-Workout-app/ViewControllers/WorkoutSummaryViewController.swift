//
//  WorkoutSummaryViewController.swift
//  iOS-Workout-app
//
//  Created by Yael Bilu Eran on 29/11/2020.
//

import UIKit

class WorkoutSummaryViewController: UIViewController {
    
    //  MARK: outlets
    @IBOutlet weak var summaryLabel: UILabel!
    
    // MARK: proprieties
    let vModel = WorkoutSummaryViewModel()
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        summaryLabel.text = vModel.summaryText
    }
}
