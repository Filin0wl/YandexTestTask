//
//  ViewController.swift
//  YandexTestTask
//
//  Created by Anastasia Perminova on 21.06.2022.
//

import UIKit

class ViewController: UIViewController {
    
// MARK: Outlets
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var gameFieldView: UIView!
    @IBOutlet weak var lastScoreLabel: UILabel!
    @IBOutlet weak var timeStepper: UIStepper!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var shapeX: NSLayoutConstraint!
    @IBOutlet weak var shapeY: NSLayoutConstraint!
    @IBOutlet weak var shapeView: UIImageView!
    
// MARK: Varialble
    var gameTimer: Timer = Timer()
    var shapeTimer = Timer()
    var timerIsActive = false
    var countOfTimer = 30 {
        didSet {
            changedTimeLabel()
        }
    }
    let displayDuration: TimeInterval = 2
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: field
        gameFieldView.layer.borderColor = UIColor.gray.cgColor
        gameFieldView.layer.borderWidth = CGFloat(1.0)
        gameFieldView.layer.cornerRadius = CGFloat(8.0)
    }

    @IBAction func stepperChanged(_ sender: UIStepper) {
        countOfTimer = Int(sender.value)
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        if !timerIsActive {
            startGame()
        } else {
            stopGame()
        }
        
    }
    
    @objc func tick() {
        countOfTimer -= 1
        if countOfTimer == 0 {
            gameTimer.invalidate()
        }
    }
    
    func startGame() {
        timeStepper.isEnabled = false
        timerIsActive = true
        changedTimeLabel()
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
        shapeTimer = Timer.scheduledTimer(timeInterval: displayDuration, target: self, selector: #selector(moveImage), userInfo: nil, repeats: true)
        startStopButton.setTitle("Остановить", for: .normal)
    }
    
    
    func stopGame() {
        gameTimer.invalidate()
        shapeTimer.invalidate()
        timerIsActive = false
        countOfTimer = 30
        timeStepper.isEnabled = true
        startStopButton.setTitle("Начать", for: .normal)
        lastScoreLabel.text = "Последний счет: 1"
    }
    
    func changedTimeLabel() {
        if timerIsActive {
            mainLabel.text = "Осталось: \(countOfTimer) сек"
        } else {
            mainLabel.text = "Время: \(countOfTimer) сек"
        }
    }
    
    @objc func moveImage() {
        let maxX = gameFieldView.bounds.maxX - shapeView.frame.width
        let maxY = gameFieldView.bounds.maxY - shapeView.frame.height
        shapeX.constant = CGFloat(arc4random_uniform(UInt32(maxX)))
        shapeY.constant = CGFloat(arc4random_uniform(UInt32(maxY)))
    }
    
}
