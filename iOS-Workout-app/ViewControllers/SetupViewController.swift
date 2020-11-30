//
//  ViewController.swift
//  iOS-Workout-app
//
//  Created by Neta Osman on 23/11/2020.
//

import UIKit

class SetupViewController: UIViewController {
    
    //  MARK: outlets
    @IBOutlet weak var aButton: PinkButton!
    @IBOutlet weak var bButton: PinkButton!
    @IBOutlet weak var cButton: PinkButton!
    @IBOutlet weak var dButton: PinkButton!
    @IBOutlet weak var eButton: PinkButton!
    @IBOutlet weak var fButton: PinkButton!
    
    // MARK: proprieties
    static var buttons: [UIButton] = []
    private let vModel = SetupViewModel()
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for button in SetupViewController.buttons {
            button.setTitle(vModel.getLabelForButton(tag: button.tag), for: .normal)
        }
        
        for button in SetupViewController.buttons {
            button.addTarget(self, action: #selector(self.buttonTapped), for: .touchUpInside)
        }
    }
    
    @objc
    func buttonTapped(sender: UIButton!) {
        let results = vModel.addDigite(tag: sender.tag)
        if results == .completed {
            performSegue(withIdentifier: "showWorkout", sender: nil)
        } else if results == .failed {
            let alert = UIAlertController(title: "Try that again", message: "The code you entered is incorrect", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
}

class PinkButton: UIButton {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        onInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        onInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        onPostInit()
    }
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                backgroundColor =  UIColor(red: 219/255, green: 92/255, blue: 156/255, alpha: 1.0)
            } else {
                backgroundColor =  UIColor(red: 244/255, green: 219/255, blue: 234/255, alpha: 1.0)
            }
        }
    }
    
    func onInit() {
        clipsToBounds = true
        self.layer.cornerRadius = self.frame.size.width / 2
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        SetupViewController.buttons.append(self)
    }
    func onPostInit() {}
}

