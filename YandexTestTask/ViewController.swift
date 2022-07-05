//
//  ViewController.swift
//  YandexTestTask
//
//  Created by Anastasia Perminova on 21.06.2022.
//

import UIKit

class ViewController: UIViewController {
    
// MARK: Outlets
    @IBOutlet weak var gameFieldView: GameFieldView!
    @IBOutlet weak var lastScoreLabel: UILabel!
    @IBOutlet weak var gameControl: GameControlView!
    
            
// MARK: Variable
    var gameTimer: Timer = Timer()
    var shapeTimer = Timer()
    let displayDuration: TimeInterval = 2
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: field
        gameFieldView.layer.borderColor = UIColor.gray.cgColor
        gameFieldView.layer.borderWidth = CGFloat(1.0)
        gameFieldView.layer.cornerRadius = CGFloat(8.0)
        gameFieldView.isShapeHidden = !gameControl.isGameActive
        gameFieldView.shapeHitHandler = { [weak self] in self?.shapeTapGestureRecognizer()}
        gameControl.startStopHandler = { [weak self] in
            self?.buttonClicked()}
        gameControl.gameDuration = 20
    }
    
    func shapeTapGestureRecognizer() {
        guard gameControl.isGameActive else { return }
        score += 1
        moveImageWithResetTimer()
    }
    
    //MARK: Methods
    
    func buttonClicked() {
        if !gameControl.isGameActive {
            startGame()
        } else {
            stopGame()
        }
        
    }
    
    @objc func tick() {
        gameControl.gameTimeLeft -= 1
        if gameControl.gameTimeLeft == 0 {
            stopGame()
        }
    }
    
    func startGame() {
        gameControl.isGameActive = true
        gameFieldView.isShapeHidden = !gameControl.isGameActive
                
        moveImage()
        setShapeTimer()
        
        gameControl.gameTimeLeft = gameControl.gameDuration
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
        //startStopButton.setTitle("Остановить", for: .normal)
    }
    
    
    func stopGame() {
        gameControl.isGameActive = false
        gameTimer.invalidate()
        shapeTimer.invalidate()
        gameFieldView.isShapeHidden = !gameControl.isGameActive
        //startStopButton.setTitle("Начать", for: .normal)
        lastScoreLabel.text = "Последний счет: \(score)"
        score = 0
    }
    
    @objc func moveImage() {
        gameFieldView.randomizeShapePosition()
    }
    
    func moveImageWithResetTimer() {
        shapeTimer.invalidate()
        setShapeTimer()
        shapeTimer.fire()
    }
    
    func setShapeTimer() {
        shapeTimer = Timer.scheduledTimer(timeInterval: displayDuration, target: self, selector: #selector(moveImage), userInfo: nil, repeats: true)
    }
}
