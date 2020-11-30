//
//  SplashScreenViewController.swift
//  iOS-Workout-app
//
//  Created by Yael Bilu Eran on 29/11/2020.
//

import UIKit

class SplashScreenViewController: UIViewController {
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        WorkoutService.shared.loadData{ [weak self] succeed in
            if succeed {
                self?.performSegue(withIdentifier: "showSetup", sender: nil)
            }
        }
    }
}
