//
//  GameControlView.swift
//  YandexTestTask
//
//  Created by Anastasia Perminova on 05.07.2022.
//

import UIKit

@IBDesignable
class GameControlView: UIView {
    
    //MARK: Constants
    private let timeLabel: UILabel!
    private let stepper: UIStepper!
    private let actionButton: UIButton!
    
    //MARK: Inspectable variableis
    @IBInspectable var gameTimeLeft: Double = 7 {
        didSet {
            updateTimeLabel()
        }
    }
    @IBInspectable var isGameActive: Bool = false {
        didSet {
            updateTimeLabel()
            updateButtonLabel()
        }
    }
    @IBInspectable var gameDuration: Double {
        get {
            return stepper.value
        }
        set {
            stepper.value = newValue
            updateTimeLabel()
        }
    }
    
    //MARK: Variables
    var startStopHandler: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupVIews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupVIews()
    }
    
    private func setupVIews() {
        addSubview(timeLabel)
        addSubview(stepper)
        addSubview(actionButton)
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = true
        stepper.translatesAutoresizingMaskIntoConstraints = true
        actionButton.translatesAutoresizingMaskIntoConstraints = true
    }
    
    private func updateTimeLabel() {
        stepper.isEnabled = !isGameActive
        if isGameActive {
            timeLabel.text = "Осталось: \(Int(gameTimeLeft)) сек"
            
        } else {
            timeLabel.text = "Время: \(Int(stepper.value)) сек"
        }
    }
    
    private func updateButtonLabel(){
        if isGameActive {
            actionButton.setTitle("Остановить", for: .normal)
        } else {
            actionButton.setTitle("Начать", for: .normal)
        }
    }
    
    
    func stepperChanged() {
        updateTimeLabel()
    }
    
    func actionButtonTapped() {
        startStopHandler?()
    }
    
}
