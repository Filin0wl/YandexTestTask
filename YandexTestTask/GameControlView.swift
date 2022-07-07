//
//  GameControlView.swift
//  YandexTestTask
//
//  Created by Anastasia Perminova on 05.07.2022.
//

import UIKit

@IBDesignable
class GameControlView: UIView {
    
    //MARK: Views
    private let timeLabel = UILabel()
    private let stepper = UIStepper()
    private let actionButton = UIButton()
    
    
    //MARK: Inspectable variableis
    @IBInspectable var gameTimeLeft: Double = 7 {
        didSet {
            updateTimeLabel()
        }
    }
    @IBInspectable var isGameActive: Bool = false {
        didSet {
            updateUI()
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
    
    //MARK: Constants
    private let actionButtonTopMargin: CGFloat = 8
    private let timeToStepperMargin: CGFloat = 8
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupVIews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupVIews()
    }
    
    override var intrinsicContentSize: CGSize {
        let stepperSize = stepper.intrinsicContentSize
        let timeLabelSize = timeLabel.intrinsicContentSize
        let buttonSize = actionButton.intrinsicContentSize
        
        let width = timeLabelSize.width + timeToStepperMargin + stepperSize.width
        let heigth = stepperSize.height + actionButtonTopMargin + buttonSize.height
        return CGSize(width: width, height: heigth)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let stepperSize = stepper.intrinsicContentSize
        stepper.frame = CGRect (origin: CGPoint(x: bounds.maxX - stepperSize.width, y: bounds.minY), size: stepperSize)
        
        let timeLabelSize = timeLabel.intrinsicContentSize
        timeLabel.frame = CGRect(origin: CGPoint(x: bounds.midX, y: bounds.minY + (stepperSize.height - timeLabelSize.height)/2), size: timeLabelSize)
        
        let buttonSize = actionButton.intrinsicContentSize
        actionButton.frame = CGRect(origin: CGPoint(x: bounds.minX + (bounds.width - buttonSize.width) / 2, y: stepper.frame.maxY + actionButtonTopMargin), size: buttonSize)
    }
    
    private func setupVIews() {
        addSubview(timeLabel)
        addSubview(stepper)
        addSubview(actionButton)
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = true
        stepper.translatesAutoresizingMaskIntoConstraints = true
        actionButton.translatesAutoresizingMaskIntoConstraints = true
        
        stepper.addTarget(self, action: #selector(stepperChanged), for: .valueChanged)
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        
        updateUI()
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
    
    private func updateUI() {
        updateTimeLabel()
        updateButtonLabel()
    }
    
    @objc func stepperChanged() {
        updateTimeLabel()
    }
    
    @objc func actionButtonTapped() {
        startStopHandler?()
    }
    
}
